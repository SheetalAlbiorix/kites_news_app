import 'package:dartz/dartz.dart';
import 'package:kites_news_app/src/core/network/error/exceptions.dart';
import 'package:kites_news_app/src/core/network/error/failures.dart';
import 'package:kites_news_app/src/features/news/data/data_sources/remote/news_impl_api.dart';
import 'package:kites_news_app/src/features/news/domain/models/category_response.dart';
import 'package:kites_news_app/src/features/news/domain/models/list_of_category_model.dart';
import 'package:kites_news_app/src/features/news/domain/repositories/abstract_news_repository.dart';

class NewsRepositoryImpl extends AbstractNewsRepository {
  final NewsImplApi newsApi;

  NewsRepositoryImpl(
    this.newsApi,
  );

  // Gent Ny Times Articles
  @override
  Future<Either<Failure, ListOfCategoryResponse>> getListOfCategory() async {
    try {
      final result = await newsApi.getListOfCategory();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, CategoryResponse>> getCategoryResponse(
      {String? selectedCategory}) async {
    try {
      final result =
          await newsApi.getCategoryResponse(selectedCategory: selectedCategory);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }
}
