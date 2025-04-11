import 'package:kites_news_app/src/features/news/domain/models/list_of_category_model.dart';

ListOfCategoryResponse actualNewsCategoryFailedOrEmptyListData = ListOfCategoryResponse(
  timestamp: null,
  categories: [],
);

ListOfCategoryResponse actualNewsCategoryListData = ListOfCategoryResponse(
  timestamp: 123456789,
  categories: [Category(file: "", name: "Name")],
);
