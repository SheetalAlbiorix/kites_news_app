import 'package:get_it/get_it.dart';
import 'package:kites_news_app/src/features/articles/articles_injections.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/app_injections.dart';
import '../network/dio_network.dart';
import '../network/web_service.dart';
import 'log/app_logger.dart';


final sl = GetIt.instance;

Future<void> initInjections() async {
  await initSharedPrefsInjections();
  await initAppInjections();
  await initDioInjections();
  await initArticlesInjections();
}

initSharedPrefsInjections() async {
  sl.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
  await sl.isReady<SharedPreferences>();
}

Future<void> initDioInjections() async {
  initRootLogger();
  sl.registerSingleton<DioNetwork>(DioNetwork());
  sl.registerSingleton<ApiService>(ApiService());
  // DioNetwork.initDio();
}
