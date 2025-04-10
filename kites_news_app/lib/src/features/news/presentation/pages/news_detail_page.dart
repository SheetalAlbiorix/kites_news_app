import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:kites_news_app/src/features/news/domain/models/category_response.dart';
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
                      Text(
                        'Articles :',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      AnimationLimiter(
                        child: ListView.builder(
                          itemCount: widget.clusterModel.articles?.length ?? 0,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final article = widget.clusterModel.articles![index];
                            final date = DateTime.tryParse(article.date.toString());
                            final formattedDate = date != null
                                ? DateFormat('yMMMd – HH:mm').format(date)
                                : '';

                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 400),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: Card(
                                    margin: const EdgeInsets.symmetric(vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            article.title ?? '',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            '${article.domain} • $formattedDate',
                                            style: const TextStyle(
                                                fontSize: 12, color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
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
}
