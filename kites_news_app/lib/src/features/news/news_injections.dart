import 'package:kites_news_app/src/core/network/web_service.dart';
import 'package:kites_news_app/src/core/utils/injections.dart';
import 'package:kites_news_app/src/features/news/data/data_sources/remote/news_impl_api.dart';
import 'package:kites_news_app/src/features/news/domain/repositories/abstract_news_repository.dart';
import 'data/repositories/news_repo_impl.dart';

initNewsInjections() {
  sl.registerSingleton<NewsImplApi>(NewsImplApi(sl<ApiService>()));
  sl.registerSingleton<AbstractNewsRepository>(NewsRepositoryImpl(sl()));
}
