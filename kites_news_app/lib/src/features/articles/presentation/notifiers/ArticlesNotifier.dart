import '../../../../core/network/response.dart';
import '../../domain/models/article_model.dart';
import '../../domain/models/articles_params.dart';
import '../../domain/repositories/abstract_articles_repository.dart';
import 'base_notifier.dart';

class ArticlesNotifier extends BaseNotifier implements ArticlesProvEvent {
  final AbstractArticlesRepository articlesRepository;

  BaseApiResponse<List<ArticleModel>> articleResponse = BaseApiResponse.loading();

  ArticlesNotifier({required this.articlesRepository});

  @override
  Future<void> getArticles(ArticlesParams params) async {
    try {
       apiResIsLoading(articleResponse);
      final result = await articlesRepository.getArticles(params);

      result.fold(
              (failure) => apiResIsFailed(articleResponse, failure),
              (data) => apiResIsSuccess(articleResponse, data));
    } catch (e) {
      apiResIsFailed(articleResponse, e);
    }
  }
}

abstract class ArticlesProvEvent {
  Future<void> getArticles(ArticlesParams params);
}
