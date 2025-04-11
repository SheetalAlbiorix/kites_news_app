import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kites_news_app/src/core/style/app_colors.dart';
import 'package:kites_news_app/src/core/translations/l10n.dart';
import 'package:kites_news_app/src/features/news/domain/models/category_response.dart';
import 'package:kites_news_app/src/features/news/presentation/notifiers/article_pagination_notifier.dart';
import 'package:kites_news_app/src/features/news/presentation/widgets/news_detail_helper.dart';
import 'package:kites_news_app/src/shared/presentation/pages/background_page.dart';
import 'package:kites_news_app/src/shared/presentation/widgets/arrow_back_button_widget.dart';
import 'package:kites_news_app/src/shared/presentation/widgets/custom_app_bar_widget.dart';
import 'package:provider/provider.dart';

class ArticleDetailPage extends StatefulWidget {

  final List<Article> articleList;

  const ArticleDetailPage({super.key,required this.articleList});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  final NewsDetailHelper newsDetailHelper = NewsDetailHelper();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final provider = Provider.of<ArticlePaginationProvider>(context, listen: false);
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
      provider.loadMoreArticles();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      withDrawer: true,
      child: Column(
        children: [
          CustomAppBarWidget(
            title: Text(
              S.of(context).articles,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: ArrowBackButtonWidget(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: detailContent(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget detailContent(BuildContext ctx){
    final provider = Provider.of<ArticlePaginationProvider>(ctx);

    return  AnimationLimiter(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: provider.visibleArticles.length + (provider.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == provider.visibleArticles.length) {
            // Loader widget at the end
            return  Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.black,
                ),
              ),
            );
          }

          final article = provider.visibleArticles[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 400),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: newsDetailHelper.articlesList(articleList: article),
              ),
            ),
          );
        },
      ),
    );
  }
}


