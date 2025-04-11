import 'package:kites_news_app/src/features/news/domain/models/list_of_category_model.dart';

import 'actual_news_category_json.dart';

ListOfCategoryResponse expectedEmptyCategoryListData = ListOfCategoryResponse.fromJson(
  actualEmptyCategoryJson,
);

ListOfCategoryResponse expectedCategoryListData = ListOfCategoryResponse.fromJson(
  actualCategoryListJson,
);
