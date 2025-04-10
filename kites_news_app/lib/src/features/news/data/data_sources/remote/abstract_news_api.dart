

import 'package:kites_news_app/src/features/news/domain/models/category_response.dart';
import 'package:kites_news_app/src/features/news/domain/models/list_of_category_model.dart';

abstract class AbstractNewsApi {
  // Get all article
  Future<ListOfCategoryResponse> getListOfCategory();

  Future<CategoryResponse> getCategoryResponse({String? selectedCategory});
}
