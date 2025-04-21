import 'package:dartz/dartz.dart';
import 'package:kites_news_app/src/core/network/error/failures.dart';
import 'package:kites_news_app/src/features/news/domain/models/category_response.dart';
import 'package:kites_news_app/src/features/news/domain/models/list_of_category_model.dart';

import '../../data_sources/category_mock_data/expected_news_category_data.dart';
import '../../data_sources/clustor_mock_data/expected_news_category_data.dart';

Right expectedNewsCategoryEmptyListData = Right(apiModelEmptyCategoryListData);

Right<Failure, ListOfCategoryResponse> expectedNewsCategoryListData = Right(
  apiModelCategoryListData,
);

Right<Failure, CategoryResponse> expectedRepoNewsClusterEmptyData = Right(
  apiModelEmptyClusterListData,
);

Right<Failure, CategoryResponse> expectedRepoNewsClusterData = Right(
  apiModelClusterListData,
);
