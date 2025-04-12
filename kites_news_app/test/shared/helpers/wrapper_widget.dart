import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kites_news_app/main.dart';
import 'package:kites_news_app/provider_list.dart';
import 'package:kites_news_app/src/core/route/router.dart';
import 'package:kites_news_app/src/core/translations/l10n.dart';
import 'package:kites_news_app/src/features/news/presentation/notifiers/category_notifier.dart';
import 'package:kites_news_app/src/features/news/presentation/pages/news_page.dart';
import 'package:provider/provider.dart';

class WrapperWidget extends StatelessWidget {
  final Widget child;
  const WrapperWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppNotifier()),
        ChangeNotifierProvider(create: (_) => newsProvider),
        ChangeNotifierProvider(create: (_) => CategoryNotifier()),
      ],
      child: Consumer<AppNotifier>(
        builder: (BuildContext context, AppNotifier value, Widget? childConsumer) {
          return MaterialApp(
            onGenerateRoute: AppRouter.generateRoute,
            routes: {
              '/news_page': (context) => NewsPage(),
            },
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            navigatorKey: navigatorKey,
            supportedLocales: const [Locale("ar"), Locale("en")],
            home: ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, childWidget) => child,
            ),
          );
        },
      ),
    );
  }
}
