
import '../../core/network/web_service.dart';
import '../../core/utils/injections.dart';
import 'data/data_sources/local/articles_shared_prefs.dart';
import 'data/data_sources/remote/articles_impl_api.dart';
import 'data/repositories/articles_repo_impl.dart';
import 'domain/repositories/abstract_articles_repository.dart';

initArticlesInjections() {
  sl.registerSingleton<ArticlesImplApi>(ArticlesImplApi(sl<ApiService>()));
  sl.registerSingleton<AbstractArticlesRepository>(ArticlesRepositoryImpl(sl()));
  sl.registerSingleton<ArticlesSharedPrefs>(ArticlesSharedPrefs(sl()));

}
