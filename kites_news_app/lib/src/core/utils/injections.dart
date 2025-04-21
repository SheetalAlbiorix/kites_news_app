import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:kites_news_app/src/core/network/dio_network.dart';
import 'package:kites_news_app/src/features/news/news_injections.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../shared/app_injections.dart';
import '../network/web_service.dart';
import 'log/app_logger.dart';

typedef DependencyOverride = T Function<T>();

Future<void> initInjections({DependencyOverride? override}) async {
  sl.registerSingleton<CacheManager>(CacheManager(
    Config(
      'customCacheKey', // Unique cache key
      stalePeriod: const Duration(days: 3),
      maxNrOfCacheObjects: 20,
    ),
  ));
  await initSharedPrefsInjections();
  await initAppInjections();
  await initDioInjections(override: override);
  await initNewsInjections();
  // await initArticlesInjections();
}

initSharedPrefsInjections() async {
  sl.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
  await sl.isReady<SharedPreferences>();
}

Future<void> initDioInjections({DependencyOverride? override}) async {
  initRootLogger();
  sl.registerSingleton<DioNetwork>(override?.call<DioNetwork>() ?? DioNetwork());
  sl.registerSingleton<ApiService>(ApiService(dio: sl<DioNetwork>()));
  // DioNetwork.initDio();
}
