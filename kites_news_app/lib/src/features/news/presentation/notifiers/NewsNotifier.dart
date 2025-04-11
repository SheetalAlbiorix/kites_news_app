import 'dart:async';

import 'package:kites_news_app/src/core/helper/base_notifier.dart';
import 'package:kites_news_app/src/core/network/response.dart';
import 'package:kites_news_app/src/features/news/domain/models/category_response.dart';
import 'package:kites_news_app/src/features/news/domain/models/list_of_category_model.dart';
import 'package:kites_news_app/src/features/news/domain/repositories/abstract_news_repository.dart';

class NewsNotifier extends BaseNotifier implements NewsProvEvent {
  final AbstractNewsRepository newsRepository;

  BaseApiResponse<ListOfCategoryResponse> newsResponse = BaseApiResponse.loading();
  BaseApiResponse<CategoryResponse> newsCategoryResponse = BaseApiResponse.loading();

  NewsNotifier({required this.newsRepository});

  @override
  Future<ListOfCategoryResponse?> getListOfCategory() async {
    try {
      apiResIsLoading(newsResponse);
      final result = await newsRepository.getListOfCategory();

      return result.fold(
        (failure) {
          apiResIsFailed(newsResponse, failure);
          return null; // Return null in case of failure
        },
        (data) {
          apiResIsSuccess(newsResponse, data);
          return data; // Return the fetched data
        },
      );
    } catch (e) {
      apiResIsFailed(newsResponse, e);
      return null;
    }
  }

  Future<void> getCategoryResponse({String? selectedCategory}) async {
    try {
      apiResIsLoading(newsCategoryResponse);
      final result =
          await newsRepository.getCategoryResponse(selectedCategory: selectedCategory);

      result.fold((failure) => apiResIsFailed(newsCategoryResponse, failure),
          (data) => apiResIsSuccess(newsCategoryResponse, data));
    } catch (e) {
      apiResIsFailed(newsCategoryResponse, e);
    }
  }
}

abstract class NewsProvEvent {
  Future<void> getListOfCategory();

  Future<void> getCategoryResponse();
}
