import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kites_news_app/src/features/news/domain/models/category_response.dart';
import 'package:kites_news_app/src/features/news/presentation/widgets/news_detail_helper.dart';
import 'package:kites_news_app/src/shared/presentation/pages/background_page.dart';
import 'package:kites_news_app/src/shared/presentation/widgets/arrow_back_button_widget.dart';
import 'package:kites_news_app/src/shared/presentation/widgets/custom_app_bar_widget.dart';

class ArticleDetailPage extends StatefulWidget {

  final List<Article> articleList;

  const ArticleDetailPage({super.key,required this.articleList});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {

  final NewsDetailHelper newsDetailHelper = NewsDetailHelper();

  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      withDrawer: true,
      child: Column(
        children: [
          CustomAppBarWidget(
            title: Text(
              "widget.articleList",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: ArrowBackButtonWidget(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: AnimationLimiter(
                    child: ListView.builder(
                      itemCount: widget.articleList.length ?? 0,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final article = widget.articleList[index];

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
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
