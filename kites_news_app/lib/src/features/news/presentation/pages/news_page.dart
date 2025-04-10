import 'package:flutter/material.dart';
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
import 'package:kites_news_app/src/shared/presentation/widgets/custom_app_bar_widget.dart';
import 'package:kites_news_app/src/shared/presentation/widgets/reload_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with SingleTickerProviderStateMixin {
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
    animationControllers.values.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppNotifier>(context);
    final categoryNotifier = Provider.of<CategoryNotifier>(context);

    return BackgroundPage(
      scaffoldKey: _key,
      withDrawer: true,
      child: Column(
        children: [
          // Custom App Bar
          CustomAppBarWidget(
            title: Text(
              S.of(context).ny_times_most_popular,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            leading: IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                _key.currentState!.openDrawer();
              },
              icon: Center(
                child: Icon(
                  Icons.menu,
                  size: 20,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon( context.watch<AppNotifier>().isDarkMode ? Icons.light_mode : Icons.dark_mode),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              ),
            ],
          ),

          SizedBox(
            height: Helper.getVerticalSpace(),
          ),

          Expanded(
            child: Consumer<NewsNotifier>(
              builder: (context, state, child) {
                if (state.newsCategoryResponse.status == Status.loading) {
                  Center(child: AppLoader());
                }
                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  header: WaterDropHeader(
                    waterDropColor: Theme.of(context).cardColor,
                  ),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                        child: Consumer<CategoryNotifier>(
                          builder: (BuildContext context, value, Widget? child) {
                            final selectedCategory = categoryNotifier.getSelectedCategory;
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              itemCount: state.newsResponse.data?.categories?.length ?? 0,
                              itemBuilder: (context, index) {
                                final category =
                                    state.newsResponse.data?.categories?[index];
                                final isSelected =
                                    selectedCategory?.file == category?.file;

                                return newsHelper.filterChip(
                                    onTap: () {
                                      categoryNotifier.setSelectedCategory(category);
                                      callArticles();
                                    },
                                    categoryName: category?.name ?? '',
                                    isSelected: isSelected);
                              },
                            );
                          },
                        ),
                      ),
                      if (state.newsCategoryResponse.data?.clusters?.isNotEmpty ?? false)
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.newsCategoryResponse.data?.clusters?.length,
                            itemBuilder: (context, index) {
                              if (!animationControllers.containsKey(index)) {
                                animationControllers[index] = AnimationController(
                                  duration: Duration(milliseconds: 500 + (index * 50)),
                                  vsync: Scaffold.of(context),
                                );
                              }

                              final Animation<Offset> listItemAnimation = Tween<Offset>(
                                begin: Offset(0, 1),
                                end: Offset.zero,
                              ).animate(CurvedAnimation(
                                parent: animationControllers[index]!,
                                curve: Curves.easeOut,
                              ));

                              // Trigger animation only when the item is visible
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (!animationControllers[index]!.isAnimating &&
                                    animationControllers[index]!.status !=
                                        AnimationStatus.completed) {
                                  animationControllers[index]!.forward();
                                }
                              });
                              return Visibility(
                                visible: true,
                                child: SlideTransition(
                                  position: listItemAnimation,
                                  child: NewsCardWidget(
                                    categoryModel:
                                        state.newsCategoryResponse.data!.clusters![index],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      if ((state.newsCategoryResponse.data?.clusters ?? []).isEmpty)
                        Expanded(
                            child: Center(
                                child:
                                    ReloadWidget.empty(content: S.of(context).no_data))),
                    ],
                  ),
                );
              },
            ),
          )
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
    } else {
      print('Failed to fetch categories.');
    }
  }

  Future<void> callArticles({
    bool withLoading = true,
  }) async {
    final categoryNotifier = Provider.of<CategoryNotifier>(context, listen: false);
    final selectedCategory =
        categoryNotifier.getSelectedCategory;

    if (selectedCategory != null) {
      await newsNotifier.getCategoryResponse(selectedCategory: selectedCategory.file);
    }
  }
  
  void _onRefresh() async {
    _refreshController.requestRefresh();
    callArticles(withLoading: false);
  }
}
