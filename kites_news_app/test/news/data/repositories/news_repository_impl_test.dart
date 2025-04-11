import 'package:flutter_test/flutter_test.dart';
import 'package:kites_news_app/src/features/news/data/data_sources/remote/news_impl_api.dart';
import 'package:kites_news_app/src/features/news/data/repositories/news_repo_impl.dart';
import 'package:kites_news_app/src/features/news/domain/repositories/abstract_news_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mock_data/news_category_mock/actual_articles_data.dart';
import 'mock_data/news_category_mock/expected_articles_data.dart';
import 'news_repository_impl_test.mocks.dart';

@GenerateMocks([NewsImplApi])
void main() {
  // Mocked NewsImplApi class
  late MockNewsImplApi mockApi;

  // Our Repository class that we need to test it.
  // The dependency for this class will get from the mocked NewsImplApi class not from
  // real NewsImplApi class
  late AbstractNewsRepository newsRepositoryImpl;
  setUp(() {
    mockApi = MockNewsImplApi();
    newsRepositoryImpl = NewsRepositoryImpl(mockApi);
  });

  group("Test news_rep_impl", () {
    test("Get All Categories - Failed Case, Empty Or Null Api response", () async {
      when(mockApi.getListOfCategory()).thenAnswer((realInvocation) async {
        return actualNewsCategoryFailedOrEmptyListData;
      });
      var result;

      try {
        result = await newsRepositoryImpl.getListOfCategory();
      } catch (e) {
        result = e;
      }
      expect(result.value, expectedNewsCategoryEmptyListData.value);
    });

    test("Get All Categories - Success Case", () async {
      when(mockApi.getListOfCategory()).thenAnswer((realInvocation) async {
        return actualNewsCategoryListData;
      });
      var result;
      try {
        result = await newsRepositoryImpl.getListOfCategory();
      } catch (e) {
        result = e;
      }
      expect(result.value, expectedNewsCategoryListData.value);
    });
  });
}
