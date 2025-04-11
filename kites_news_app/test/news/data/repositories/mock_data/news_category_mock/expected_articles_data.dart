import 'package:dartz/dartz.dart';
import 'package:kites_news_app/src/core/network/error/failures.dart';
import 'package:kites_news_app/src/features/news/domain/models/list_of_category_model.dart';

Right expectedNewsCategoryEmptyListData = Right(
  ListOfCategoryResponse(timestamp: null, categories: []),
);

Right<Failure, ListOfCategoryResponse> expectedNewsCategoryListData = Right(
  ListOfCategoryResponse(
    timestamp: 123456789,
    categories: [Category(file: "", name: "Name")],
  ),
);
