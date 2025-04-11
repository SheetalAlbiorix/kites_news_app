import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kites_news_app/src/core/style/app_colors.dart';
import 'package:lottie/lottie.dart';

class AppLoader extends StatelessWidget {
  final Color? iconColor;

  const AppLoader({
    Key? key,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Lottie.asset(
              AppColors().loadingAnimationData,
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          )),
    );
  }
}
