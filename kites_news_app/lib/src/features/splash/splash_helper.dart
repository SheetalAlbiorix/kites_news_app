
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kites_news_app/src/core/helper/helper.dart';
import 'package:kites_news_app/src/core/route/app_route_enum.dart';

class SplashHelper {
  final doAnimationNotifier = ValueNotifier<bool>(false);
  final moveToTop = ValueNotifier<bool>(false);

  Widget splashBgImageWidgets() {
    return Positioned.fill(
      child: FadeIn(
        child: Container(
          color: Colors.white.withValues(alpha: 0.1),
        ),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastOutSlowIn,
        animate: true,
        onFinish: (v) {
          doAnimationNotifier.value = true;
        },
      ),
    );
  }

  ///AppLogo Animation
  Widget buildScaleTransition(
      {Function(AnimateDoDirection direction)? onFinishMethod}) {
    return ValueListenableBuilder(
      valueListenable: doAnimationNotifier,
      builder: (context, _, child) => ValueListenableBuilder(
        valueListenable: moveToTop,
        builder: (context, _, child) => TweenAnimationBuilder(
          tween: Tween<Offset>(
            begin: const Offset(0, 0),
            end: Offset(0, moveToTop.value ? -0.5 : 0),
          ),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
          builder: (context, offset, child) {
            return TweenAnimationBuilder(
              tween:
              Tween<double>(begin: 1.0, end: moveToTop.value ? 0.0 : 1.0),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
              builder: (context, opacity, child) {
                return Align(
                  alignment: Alignment(0, offset.dy),
                  child: Opacity(
                    opacity: opacity,
                    child: ZoomIn(
                      animate: doAnimationNotifier.value,
                      duration: const Duration(milliseconds: 1000),
                      onFinish: (_) {
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          moveToTop.value = true;
                          Future.delayed(const Duration(milliseconds: 1000),
                                  () async {
                                    Navigator.pushNamed(
                                      context,
                                      AppRouteEnum.newsPage.name,
                                    );
                              });
                        });
                      },
                      child: Image.asset(
                        Helper.getImagePath('splash_image.png'), // The logo path
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}