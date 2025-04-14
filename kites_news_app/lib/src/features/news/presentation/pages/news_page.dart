import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kites_news_app/main.dart';
import 'package:kites_news_app/src/core/helper/helper.dart';
import 'package:kites_news_app/src/core/network/response.dart';
import 'package:kites_news_app/src/core/translations/l10n.dart';
import 'package:kites_news_app/src/features/news/domain/models/list_of_category_model.dart';
import 'package:kites_news_app/src/features/news/presentation/notifiers/NewsNotifier.dart';
import 'package:kites_news_app/src/features/news/presentation/notifiers/category_notifier.dart';
import 'package:kites_news_app/src/features/news/presentation/widgets/news_card_widget.dart';
import 'package:kites_news_app/src/features/news/presentation/widgets/news_helper.dart';
import 'package:kites_news_app/src/shared/presentation/pages/background_page.dart';
import 'package:kites_news_app/src/shared/presentation/widgets/app_loader.dart';
import 'package:kites_news_app/src/shared/presentation/widgets/reload_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with TickerProviderStateMixin {
  late NewsNotifier newsNotifier;
  GlobalKey<ScaffoldState> _key = GlobalKey();
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  final Map<int, AnimationController> animationControllers = {};
  final NewsHelper newsHelper = NewsHelper();

  @override
  void initState() {
    Future.microtask(() async {
      newsNotifier = Provider.of<NewsNotifier>(context, listen: false);
      _fetchCategories();
    });
    super.initState();
  }

  @override
  void dispose() {
    animationControllers.forEach((_, controller) => controller.dispose());
    _refreshController.dispose();
    super.dispose();
  }

  void _resetAnimations(int itemCount) {
    animationControllers.forEach((_, controller) => controller.dispose());
    animationControllers.clear();
    for (int i = 0; i < itemCount; i++) {
      animationControllers[i] = AnimationController(
        duration: Duration(milliseconds: 500 + (i * 50)),
        vsync: this,
      )..forward();
    }
  }

  Future<void> _triggerHapticFeedback() async {
    await HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppNotifier>(context);
    final categoryNotifier = Provider.of<CategoryNotifier>(context);

    return BackgroundPage(
      scaffoldKey: _key,
      withDrawer: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          S.of(context).kite_news,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              _key.currentState!.openDrawer();
            },
            icon: Icon(Icons.menu, size: 20)),
        actions: [
          IconButton(
            icon: Icon(
              context.watch<AppNotifier>().isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: Helper.getVerticalSpace()),
          SizedBox(
            height: 50,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Consumer<NewsNotifier>(
                builder: (context, state, child) {
                  return Consumer<CategoryNotifier>(
                    builder: (context, value, child) {
                      final selectedCategory = categoryNotifier.getSelectedCategory;
                      final categories = state.newsResponse.data?.categories;
                      if (categories == null || categories.isEmpty) {
                        return SizedBox.shrink();
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          final isSelected = selectedCategory?.file == category.file;

                          return newsHelper.filterChip(
                              onTap: () async {
                                await _triggerHapticFeedback();
                                categoryNotifier.setSelectedCategory(category);
                                await callArticles();
                              },
                              isSelected: isSelected,
                              index: index,
                              categoryName: category.name ?? "");
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Consumer<NewsNotifier>(
              builder: (context, state, child) {
                if (state.newsCategoryResponse.status == Status.loading) {
                  return Center(child: AppLoader());
                }
                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  header: WaterDropHeader(
                    waterDropColor: Theme.of(context).cardColor),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: ListView(
                    children: [
                      if (state.newsCategoryResponse.data?.clusters?.isNotEmpty ?? false)
                        ...List.generate(
                          state.newsCategoryResponse.data!.clusters!.length,
                              (index) {
                            if (!animationControllers.containsKey(index)) {
                              animationControllers[index] = AnimationController(
                                duration: Duration(milliseconds: 500 + (index * 50)),
                                vsync: this,
                              );
                            }
                            final Animation<Offset> listItemAnimation = Tween<Offset>(
                              begin: Offset(1, 0),
                              end: Offset.zero,
                            ).animate(CurvedAnimation(
                              parent: animationControllers[index]!,
                              curve: Curves.easeOut,
                            ));

                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (animationControllers[index]!.status != AnimationStatus.completed) {
                                animationControllers[index]!.forward();
                              }
                            });

                            return SlideTransition(
                              position: listItemAnimation,
                              child: NewsCardWidget(
                                key: ValueKey("clusterKey_${index}"),
                                categoryModel: state.newsCategoryResponse.data!.clusters![index],
                              ),
                            );
                          },
                        ),
                      if ((state.newsCategoryResponse.data?.clusters ?? []).isEmpty &&
                          state.newsCategoryResponse.status == Status.completed)
                        Center(
                          child: ReloadWidget.empty(content: S.of(context).no_data),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchCategories() async {
    ListOfCategoryResponse? categories = await newsNotifier.getListOfCategory();
    if (categories != null) {
      Category worldCategory = categories.categories!.firstWhere(
        (category) => category.name == 'World',
        orElse: () => Category(file: 'world.json', name: 'World'),
      );
      final categoryNotifier = Provider.of<CategoryNotifier>(context, listen: false);
      categoryNotifier.setSelectedCategory(worldCategory);
      callArticles();
    } else {}
  }

  Future<void> callArticles({bool withLoading = true}) async {
    final categoryNotifier = Provider.of<CategoryNotifier>(context, listen: false);
    final selectedCategory = categoryNotifier.getSelectedCategory;
    if (selectedCategory != null) {
      await newsNotifier.getCategoryResponse(selectedCategory: selectedCategory.file);
      if (newsNotifier.newsCategoryResponse.data?.clusters != null) {
        _resetAnimations(newsNotifier.newsCategoryResponse.data!.clusters!.length);
      }
    }
  }

  void _onRefresh() async {
    _refreshController.requestRefresh();
    callArticles(withLoading: false);
    _refreshController.refreshCompleted();
  }
}
