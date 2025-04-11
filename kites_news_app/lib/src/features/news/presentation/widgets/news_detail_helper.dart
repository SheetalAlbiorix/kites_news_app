import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kites_news_app/src/features/news/domain/models/category_response.dart';
import 'package:kites_news_app/src/shared/presentation/widgets/cached_image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailHelper {
  Widget articlesList({Article? articleList,required BuildContext context,String? sourceImage}) {
    final date = DateTime.tryParse(articleList?.date.toString() ?? '');
    final formattedDate = date != null ? DateFormat('yMMMd').format(date) : '';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    articleList?.title ?? '',
                    style:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color:Theme.of(context).colorScheme.onPrimary,),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                CachedImageWidget(
                  imageUrl: articleList?.image,
                  height: 60,
                  width: 80,
                  radius: 12,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                CachedImageWidget(
                  imageUrl: sourceImage,
                  width: 15,
                  height: 15,
                ),
                GestureDetector(
                  onTap: () async {
                    _launchUrl(url: articleList?.link);
                  },
                  child: Text(
                    '${articleList?.domain}',
                          style:  TextStyle(fontSize: 14,color:Theme.of(context).colorScheme.onSecondary,),
                  ),
                ),
                const Spacer(), // Pushes the date to the end
                Text(
                  '$formattedDate',
                        style:  TextStyle(fontSize: 12, color:Theme.of(context).colorScheme.onSecondary,),
                )
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl({String? url}) async {
    final Uri _url = Uri.parse(url ?? '');

    if (!await launchUrl(
      _url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $_url');
    }
  }
}
