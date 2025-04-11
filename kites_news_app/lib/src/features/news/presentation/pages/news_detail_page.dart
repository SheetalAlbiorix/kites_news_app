import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kites_news_app/src/core/route/app_route_enum.dart';
import 'package:kites_news_app/src/core/style/app_colors.dart';
import 'package:kites_news_app/src/core/translations/l10n.dart';
import 'package:kites_news_app/src/features/news/domain/models/category_response.dart';
import 'package:kites_news_app/src/features/news/presentation/widgets/news_detail_helper.dart';
import 'package:kites_news_app/src/shared/presentation/pages/background_page.dart';
import 'package:kites_news_app/src/shared/presentation/widgets/arrow_back_button_widget.dart';
import 'package:kites_news_app/src/shared/presentation/widgets/cached_image_widget.dart';
import 'package:kites_news_app/src/shared/presentation/widgets/custom_app_bar_widget.dart';

class NewsDetailPage extends StatefulWidget {
  final Cluster clusterModel;

  const NewsDetailPage({super.key, required this.clusterModel});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  String? imageUrl;

  final NewsDetailHelper newsDetailHelper = NewsDetailHelper();

  @override
  Widget build(BuildContext context) {
    imageUrl = widget.clusterModel.articles
            ?.firstWhere(
              (article) => article.image?.isNotEmpty == true,
              orElse: () => widget.clusterModel.articles!.first,
            )
            .image ??
        widget.clusterModel.articles?.first.image;

    return BackgroundPage(
      withDrawer: true,
      child: Column(
        children: [
          CustomAppBarWidget(
            title: Text(
              "${widget.clusterModel.category}",
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
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${widget.clusterModel.title}',
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        '${widget.clusterModel.shortSummary}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      CachedImageWidget(
                        imageUrl: imageUrl,
                        height: ScreenUtil().screenHeight * 0.3,
                        width: ScreenUtil().screenWidth,
                        radius: 12,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).articles,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRouteEnum.articleDetailPage.name,
                                arguments: widget.clusterModel.articles,
                              );
                            },
                            child: Text(
                              S.of(context).more,
                              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  decorationStyle: TextDecorationStyle.dashed,
                                  decorationColor: AppColors.black),
                            ),
                          ),
                        ],
                      ),
                      articleList(),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget articleList() {
    return AnimationLimiter(
      child: ListView.builder(
        itemCount: min(10, widget.clusterModel.articles?.length ?? 0),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final article = widget.clusterModel.articles![index];

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
