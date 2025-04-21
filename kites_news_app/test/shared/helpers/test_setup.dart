import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus_platform_interface/connectivity_plus_platform_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kites_news_app/main.dart';
import 'package:kites_news_app/src/core/network/dio_network.dart';
import 'package:kites_news_app/src/core/network/web_service.dart';
import 'package:kites_news_app/src/features/news/data/data_sources/remote/news_impl_api.dart';
import 'package:kites_news_app/src/features/news/data/repositories/news_repo_impl.dart';
import 'package:kites_news_app/src/features/news/domain/repositories/abstract_news_repository.dart';
import 'package:kites_news_app/src/shared/data/data_sources/app_shared_prefs.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

import '../mocks/fake_cache_manager.dart';
import '../mocks/fake_shared_preferences_store.dart';
import '../mocks/mock_connectivity.dart';
import 'test_setup.mocks.dart';

@GenerateMocks([DioNetwork])
Future<void> initTestEnvironment() async {
  WidgetsFlutterBinding.ensureInitialized();

  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;

  sl.registerSingleton<CacheManager>(FakeCacheManager());

  ConnectivityPlatform.instance = MockConnectivityPlatform();

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(SystemChannels.platform, (methodCall) async {
    if (methodCall.method == 'HapticFeedback.vibrate') {
      return null;
    }
    return null;
  });

  await testInitInjections();
}

Future<void> testInitInjections() async {
  await initSharedPrefsInjections();

  sl.registerSingletonAsync<AppSharedPrefs>(() async {
    final prefs = sl<SharedPreferences>();
    return AppSharedPrefs(prefs);
  });
  await sl.isReady<AppSharedPrefs>();

  await sl.allReady();
  await initDioInjections();
  sl.registerSingleton<NewsImplApi>(NewsImplApi(sl<ApiService>()));
  sl.registerSingleton<AbstractNewsRepository>(NewsRepositoryImpl(sl()));
}

Future initSharedPrefsInjections() async {
  sl.registerSingletonAsync<SharedPreferences>(() async {
    ///Mocking the SharedPreferencePlatform Instance
    SharedPreferencesAsyncPlatform.instance = FakeSharedPreferencesAsync();
    SharedPreferences.setMockInitialValues({});
    return SharedPreferences.getInstance();
  });
  await sl.isReady<SharedPreferences>();
}

Future<void> initDioInjections() async {
  sl.registerSingleton<DioNetwork>(MockDioNetwork());
  sl.registerSingleton<ApiService>(ApiService(dio: sl<DioNetwork>()));
}
