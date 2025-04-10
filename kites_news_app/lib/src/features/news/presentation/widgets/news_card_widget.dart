import 'package:flutter/material.dart';
import 'package:kites_news_app/src/core/helper/helper.dart';
import 'package:kites_news_app/src/core/style/app_colors.dart';
import 'package:kites_news_app/src/core/utils/constant/app_constants.dart';
import 'package:kites_news_app/src/features/news/domain/models/category_response.dart';

class NewsCardWidget extends StatelessWidget {
  final Cluster categoryModel;


   NewsCardWidget({Key? key, required this.categoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${categoryModel.emoji} ${categoryModel.category} ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppColors().textColor,fontSize: 16,fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${categoryModel.title ?? defaultStr}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppColors().textColor,fontSize: 14,fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                    Text("💡 ${categoryModel.didYouKnow}", style: const TextStyle(fontStyle: FontStyle.italic)),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Helper.getVerticalSpace(),
            ),
          ],
        ),
      ),
    );
  }
}
