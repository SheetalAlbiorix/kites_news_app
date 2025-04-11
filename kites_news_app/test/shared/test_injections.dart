import 'package:kites_news_app/main.dart';
import 'package:kites_news_app/src/core/network/dio_network.dart';
import 'package:kites_news_app/src/core/network/web_service.dart';
import 'package:kites_news_app/src/features/news/news_injections.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_injections.mocks.dart';

typedef DependencyOverride = T Function<T>();

@GenerateMocks([DioNetwork])
Future<void> testInitInjections() async {
  await initSharedPrefsInjections();
  // await initAppInjections();
  await initDioInjections();
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
  sl.registerSingleton<DioNetwork>(MockDioNetwork());
  sl.registerSingleton<ApiService>(ApiService(dio: sl<DioNetwork>()));
  // DioNetwork.initDio();
}
