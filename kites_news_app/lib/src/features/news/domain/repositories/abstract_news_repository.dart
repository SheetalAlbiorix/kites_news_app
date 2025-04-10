import 'package:dartz/dartz.dart';
import 'package:kites_news_app/src/core/network/error/failures.dart';
import 'package:kites_news_app/src/features/news/domain/models/category_response.dart';
import 'package:kites_news_app/src/features/news/domain/models/list_of_category_model.dart';


abstract class AbstractNewsRepository {
  // Get Ny Times Articles
  Future<Either<Failure, ListOfCategoryResponse>> getListOfCategory();

  Future<Either<Failure, CategoryResponse>> getCategoryResponse({String? selectedCategory});
}
