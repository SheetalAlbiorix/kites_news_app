import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kites_news_app/provider_list.dart';
import 'package:kites_news_app/src/core/helper/helper.dart';
import 'package:kites_news_app/src/core/route/router.dart';
import 'package:kites_news_app/src/core/style/app_theme.dart';
import 'package:kites_news_app/src/core/translations/l10n.dart';
import 'package:kites_news_app/src/core/utils/injections.dart';
import 'package:kites_news_app/src/features/intro/presentation/pages/intro_page.dart';
import 'package:kites_news_app/src/features/news/presentation/notifiers/category_notifier.dart';
import 'package:kites_news_app/src/shared/data/data_sources/app_shared_prefs.dart';
import 'package:kites_news_app/src/shared/domain/entities/language_enum.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inject all dependencies
  await initInjections();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppNotifier()),
    ],
    child: DevicePreview(
      builder: (context) {
        return const App();
      },
      enabled: false,
    ),
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldMessengerState> snackBarKey =
  GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        LanguageEnum newLocale = Helper.getLang();
        context.read<AppNotifier>().setLocale(context, newLocale);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => articlesProvider),
        ChangeNotifierProvider(create: (_) => newsProvider),
        ChangeNotifierProvider(create: (_) => CategoryNotifier()),
      ],
      child: ChangeNotifierProvider<AppNotifier>.value(
        builder: (context, child) => child!,
        value: context.read<AppNotifier>(),
        child: Consumer<AppNotifier>(
          builder: (context, value, child) {
            return ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return MaterialApp(
                  title: 'Ny Times Articles App',
                  scaffoldMessengerKey: snackBarKey,
                  onGenerateRoute: AppRouter.generateRoute,
                  theme: value._isDarkMode ? darkAppTheme : appTheme,
                  debugShowCheckedModeBanner: false,
                  locale: value.locale,
                  builder: DevicePreview.appBuilder,
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  navigatorKey: navigatorKey,
                  supportedLocales: const [
                    Locale("ar"),
                    Locale("en"),
                  ],
                  home: const IntroPage(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class AppNotifier extends ChangeNotifier {
  late bool darkTheme;
  Locale locale = const Locale("en");

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  AppNotifier() {
    _initialise();
  }

  Future _initialise() async {
    darkTheme = Helper.isDarkTheme();
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    sl<AppSharedPrefs>().setDarkTheme(_isDarkMode);
    _isDarkMode = Helper.isDarkTheme();
    debugPrint("Theme toggled: $_isDarkMode"); // ✅ Check if this prints
    notifyListeners();
  }

  void updateThemeTitle(bool newDarkTheme) {
    darkTheme = newDarkTheme;
    if (Helper.isDarkTheme()) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    notifyListeners();
  }

  void setLocale(BuildContext context, LanguageEnum newLocale) {
    locale = Locale(newLocale.name);
    notifyListeners();
    sl<AppSharedPrefs>().setLang(newLocale);
  }
}