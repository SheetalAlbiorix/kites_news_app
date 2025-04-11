import 'package:flutter/material.dart';
import '../helper/helper.dart';

class AppColors {

 bool isDark =  Helper.isDarkTheme();

 Color get textColor => isDark ? Colors.white : Colors.black;
 Color get darkGray => isDark ? Colors.white : Color(0xFF808080);
 Color get chipBGColor => isDark ? Color(0xff727D73) : Color(0xFFD0DDD0);
 Color get errorMsgBgColor => isDark ? appbarDarkTextColor : appbarLightBGColor;
 Color get chipSelectedBGColor => isDark ? Color(0xff8A9A7A) : Color(0xFFAAB99A);
 Color get chipTextColor => isDark ? Color(0xffD0DDD0) : Color(0xFF727D73);
 Color get chipSelectedTextColor => isDark ? Color(0xffF0F0D7) : Color(0xFF3C463C);
 String get loadingAnimationData => isDark ? "assets/json/darkLoadingAnimation.json" : "assets/json/lightLoadingAnimation.json";

  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const primaryColor = Color(0xFF1A1A1A);
  static const orange = Color(0xFFFF5433);
  static const lightGray = Color(0xFFdddddd);
  static const gray = Color(0xFF9A9A9A);
  static const red = Color(0xFFD32F2F);
  static const transparent = Colors.transparent;




  static const primaryLightColor = Color(0xff41644A);
  static const secondaryLightColor = Color(0xff727D73);
  static const scaffoldLightBGColor = Color(0xffF0F0D7);
 static const appbarLightBGColor = Color(0xffAAB99A);
 static const appbarLightTextColor = Color(0xff3C463C);
 static const cardLightBg = Color(0xffD0DDD0);
 static const headLineLightText = Color(0xff3C463C);
 static const bodyLightText = Color(0xff5A665A);


 static const primaryDarkColor = Color(0xffF0F0D7);
 static const secondaryDarkColor = Color(0xffD0DDD0);
 static const scaffoldDarkBGColor = Color(0xff5A665A);
  static const appbarDarkBGColor = Color(0xff727D73);
 static const appbarDarkTextColor = Color(0xffF0F0D7);
 static const cardDarkBg = Color(0xff2F3E35);
 static const headLineDarkText = Color(0xffF0F0D7);
 static const bodyDarkText = Color(0xffD0DDD0);


}
