import 'package:dio/dio.dart';

import '../../../../../core/network/error/exceptions.dart';
import '../../../../../core/network/web_service.dart';
import '../../../../../core/utils/constant/network_constant.dart';
import '../../../domain/models/article_model.dart';
import '../../../domain/models/articles_params.dart';
import 'abstract_article_api.dart';

class ArticlesImplApi extends AbstractArticleApi {

  CancelToken cancelToken = CancelToken();

   ApiService apiService = ApiService();

  ArticlesImplApi(this.apiService);

  // Articles Method
  @override
  Future<List<ArticleModel>> getArticles(ArticlesParams params) async {
    try {
      final result = (await apiService.get(
        getArticlePath(params.period),
        options: Options(
          headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',}
        )
      ));
      if (result.data == null) throw ServerException("Unknown Error", result.statusCode);

      final List<ArticleModel> articles = (result.data['results'] as List<dynamic> )
          .map((json) => ArticleModel.fromJson(json))
          .toList();

      return articles;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }
}
