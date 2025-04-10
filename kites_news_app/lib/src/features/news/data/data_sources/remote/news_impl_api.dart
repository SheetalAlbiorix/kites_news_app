import 'package:dio/dio.dart';
import 'package:kites_news_app/src/core/helper/helper.dart';
import 'package:kites_news_app/src/core/network/error/exceptions.dart';
import 'package:kites_news_app/src/core/network/web_service.dart';
import 'package:kites_news_app/src/core/utils/constant/network_constant.dart';
import 'package:kites_news_app/src/features/news/data/data_sources/remote/abstract_news_api.dart';
import 'package:kites_news_app/src/features/news/domain/models/category_response.dart';
import 'package:kites_news_app/src/features/news/domain/models/list_of_category_model.dart';


class NewsImplApi extends AbstractNewsApi {
  CancelToken cancelToken = CancelToken();

  ApiService apiService = ApiService();

  NewsImplApi(this.apiService);

  // Articles Method
  @override
  Future<ListOfCategoryResponse> getListOfCategory() async {
    try {
      final result = (await apiService.get(getListOfCategories(),
          options: Options(headers: Helper.getHeaders())));
      if (result.data == null) throw ServerException("Unknown Error", result.statusCode);

      final ListOfCategoryResponse response =
          ListOfCategoryResponse.fromJson(result.data);

      return response;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  Future<CategoryResponse> getCategoryResponse({String? selectedCategory}) async {
    try {
      final result = (await apiService.get(getCategoryDetail(selectedCategory ?? ''),
          options: Options(headers: Helper.getHeaders())));
      if (result.data == null) throw ServerException("Unknown Error", result.statusCode);

      final CategoryResponse response = CategoryResponse.fromJson(result.data);

      return response;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }
}
