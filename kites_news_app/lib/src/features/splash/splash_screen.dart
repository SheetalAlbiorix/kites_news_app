import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:kites_news_app/src/core/helper/helper.dart';
import 'package:kites_news_app/src/core/style/app_colors.dart';
import 'package:kites_news_app/src/features/splash/splash_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with SingleTickerProviderStateMixin {


  final SplashHelper splashHelper = SplashHelper();

  @override
  void initState() {
    FlutterNativeSplash.remove();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Color(0xff384740),
      body: Stack(
        children: [
          ///Splash Background Image
          splashHelper.splashBgImageWidgets(),

          ///AppLogo Animation
          Center(child: splashHelper.buildScaleTransition()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    splashHelper.doAnimationNotifier.dispose();
    splashHelper.moveToTop.dispose();
    super.dispose();
  }
}
