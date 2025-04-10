// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:kites_news_app/src/core/helper/helper.dart';
// import 'package:kites_news_app/src/core/network/response.dart';
// import 'package:kites_news_app/src/core/translations/l10n.dart';
// import 'package:kites_news_app/src/features/articles/domain/models/article_model.dart';
// import 'package:kites_news_app/src/features/articles/domain/models/articles_params.dart';
// import 'package:kites_news_app/src/features/articles/presentation/notifiers/ArticlesNotifier.dart';
// import 'package:kites_news_app/src/features/articles/presentation/widgets/article_card_widget.dart';
// import 'package:kites_news_app/src/shared/presentation/pages/background_page.dart';
// import 'package:kites_news_app/src/shared/presentation/widgets/app_loader.dart';
// import 'package:kites_news_app/src/shared/presentation/widgets/custom_app_bar_widget.dart';
// import 'package:kites_news_app/src/shared/presentation/widgets/reload_widget.dart';
// import 'package:kites_news_app/src/shared/presentation/widgets/text_field_widget.dart';
// import 'package:provider/provider.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
//
// import '../../../../../main.dart';
//
// class ArticlesPage extends StatefulWidget {
//   const ArticlesPage({Key? key}) : super(key: key);
//
//   @override
//   State<ArticlesPage> createState() => _ArticlesPageState();
// }
//
// class _ArticlesPageState extends State<ArticlesPage> {
//   late ArticlesNotifier _bloc;
//
//   // Key for scaffold to open drawer
//   GlobalKey<ScaffoldState> _key = GlobalKey();
//
//   // Refresh controller for list view
//   RefreshController _refreshController = RefreshController(initialRefresh: false);
//
//   bool isSearching = false;
//
//   // List of articles
//   List<ArticleModel> nyTimesArticles = [];
//
//   // Search text field
//   TextEditingController _searchController = TextEditingController();
//   FocusNode _searchFocusNode = FocusNode();
//
//   // Period
//   int selectedPeriod = 1;
//
//   @override
//   void initState() {
//     Future.microtask(() async {
//       _bloc = Provider.of<ArticlesNotifier>(context, listen: false);
//       await callArticles();
//     });
//     // Call event to get ny times article
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<AppNotifier>(context);
//     return BackgroundPage(
//       scaffoldKey: _key,
//       withDrawer: true,
//       child: Column(
//         children: [
//           // Custom App Bar
//           CustomAppBarWidget(
//             title: isSearching
//                 ? Center(
//                     child: TextFieldWidget(
//                       controller: _searchController,
//                       focusNode: _searchFocusNode,
//                       hintText: S.of(context).search,
//                       onChanged: (value) {
//                         /*_bloc.add(
//                           OnSearchingArticlesEvent(
//                             (value?.trim() ?? ""),
//                           ),
//                         );*/
//                       },
//                       suffixIcon: IconButton(
//                         padding: EdgeInsets.zero,
//                         constraints: BoxConstraints(),
//                         onPressed: () {
//                           setState(() {
//                             isSearching = !isSearching;
//                             if (isSearching) {
//                               _searchFocusNode.requestFocus();
//                             } else {
//                               _searchFocusNode.unfocus();
//                               _searchController.clear();
//                               callArticles();
//                             }
//                           });
//                         },
//                         icon: Icon(
//                           Icons.close,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                   )
//                 : Text(
//                     S.of(context).ny_times_most_popular,
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//             leading: IconButton(
//               padding: EdgeInsets.zero,
//               constraints: BoxConstraints(),
//               onPressed: () {
//                 FocusManager.instance.primaryFocus?.unfocus();
//                 _key.currentState!.openDrawer();
//               },
//               icon: Center(
//                 child: Icon(
//                   Icons.menu,
//                   size: 20,
//                 ),
//               ),
//             ),
//             actions: [
//               // Search
//               if (!isSearching) ...{
//                 IconButton(
//                   padding: EdgeInsets.zero,
//                   constraints: BoxConstraints(),
//                   onPressed: () {
//                     setState(() {
//                       isSearching = !isSearching;
//                       if (isSearching) {
//                         _searchFocusNode.requestFocus();
//                       } else {
//                         _searchFocusNode.unfocus();
//                         _searchController.clear();
//                         callArticles();
//                       }
//                     });
//                   },
//                   icon: Icon(
//                     Icons.search,
//                     size: 20,
//                   ),
//                 ),
//               },
//
//               // Menu
//               PopupMenuButton(
//                 color: Theme.of(context).scaffoldBackgroundColor,
//                 padding: EdgeInsets.zero,
//                 constraints: BoxConstraints(),
//                 child: Row(
//                   children: [
//                     Center(
//                       child: Text(
//                         S.of(context).period,
//                         style: Theme.of(context).textTheme.bodyLarge,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 1.sp,
//                     ),
//                     Icon(
//                       Icons.arrow_drop_down,
//                       size: 20,
//                     ),
//                   ],
//                 ),
//                 onSelected: (value) {
//                   selectedPeriod = int.tryParse(value) ?? 1;
//                   callArticles();
//                 },
//                 elevation: 3,
//                 tooltip: S.of(context).period,
//                 itemBuilder: (BuildContext bc) {
//                   return [
//                     PopupMenuItem(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "1",
//                             style: Theme.of(context).textTheme.titleMedium,
//                           ),
//                           if (selectedPeriod == 1) ...{
//                             Icon(
//                               Icons.check,
//                               color: Theme.of(context).iconTheme.color,
//                               size: 20,
//                             ),
//                           }
//                         ],
//                       ),
//                       value: '1',
//                     ),
//                     PopupMenuItem(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "7",
//                             style: Theme.of(context).textTheme.titleMedium,
//                           ),
//                           if (selectedPeriod == 7) ...{
//                             Icon(
//                               Icons.check,
//                               color: Theme.of(context).iconTheme.color,
//                               size: 20,
//                             ),
//                           }
//                         ],
//                       ),
//                       value: '7',
//                     ),
//                     PopupMenuItem(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Center(
//                             child: Text(
//                               "30",
//                               style: Theme.of(context).textTheme.titleMedium,
//                             ),
//                           ),
//                           if (selectedPeriod == 30) ...{
//                             Icon(
//                               Icons.check,
//                               color: Theme.of(context).iconTheme.color,
//                               size: 20,
//                             ),
//                           }
//                         ],
//                       ),
//                       value: '30',
//                     )
//                   ];
//                 },
//               ),
//               IconButton(
//                 icon: Icon( context.watch<AppNotifier>().isDarkMode ? Icons.light_mode : Icons.dark_mode),
//                 onPressed: () {
//                   themeProvider.toggleTheme();
//                 },
//               ),
//             ],
//           ),
//
//           // Space
//           SizedBox(
//             height: Helper.getVerticalSpace(),
//           ),
//
//           // List of articles
//           Expanded(
//             child: Consumer<ArticlesNotifier>(
//               builder: (context, state, child) {
//                 if (state.articleResponse.status == Status.loading) {
//                   return const AppLoader();
//                 } else if (state.articleResponse.status == Status.error) {
//                   return ReloadWidget.error(
//                     content: state.articleResponse.message ?? "",
//                     onPressed: () {
//                       callArticles();
//                     },
//                   );
//                 }
//
//                 // Check if there is no data
//                 if ((state.articleResponse.data ?? []).isEmpty) {
//                   return ReloadWidget.empty(content: S.of(context).no_data);
//                 }
//
//                 return SmartRefresher(
//                   enablePullDown: true,
//                   enablePullUp: false,
//                   header: WaterDropHeader(
//                     waterDropColor: Theme.of(context).cardColor,
//                   ),
//                   controller: _refreshController,
//                   onRefresh: _onRefresh,
//                   onLoading: null,
//                   child: ListView.builder(
//                     itemCount: (state.articleResponse.data ?? []).length,
//                     itemBuilder: (context, index) {
//                       return ArticleCardWidget(
//                         nyTimesModel: state.articleResponse.data![index],
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   // Refresh method called when pull down list
//   void _onRefresh() async {
//     _refreshController.requestRefresh();
//     callArticles(withLoading: false);
//   }
//
//   // Call articles
//   Future<void> callArticles({bool withLoading = true}) async {
//     await _bloc.getArticles(ArticlesParams(period: 1));
//   }
// }
