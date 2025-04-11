import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kites_news_app/src/core/style/app_colors.dart';

import '../../../core/helper/helper.dart';

class CachedImageWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final String? imageUrl;
  final double? radius;
  final GlobalKey _backgroundImageKey = GlobalKey();

  CachedImageWidget({
    Key? key,
    this.width,
    this.height,
    required this.imageUrl,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: Container(
          decoration: radius == null
              ? null
              : BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(radius ?? 0))),
          height: height,
          width: width,
          child: imageUrl != null && imageUrl != ""
              ? CachedNetworkImage(
                  key: _backgroundImageKey,
                  imageUrl: imageUrl ?? "",
                  height: height,
                  width: width,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Image.asset(
                    Helper.getImagePath("no_image.png"),
                    fit: BoxFit.contain,
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: Colors.black,
                  )),
                )
              : Image.asset(
                  Helper.getImagePath("logo.png"),
                  height: height,
                  width: width,
                  fit: BoxFit.contain,
                ),
      ),
    );
  }
}
