import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kites_news_app/main.dart';
import 'package:kites_news_app/src/core/helper/helper.dart';
import 'package:kites_news_app/src/core/network/dio_network.dart';
import 'package:kites_news_app/src/core/network/error/exceptions.dart';
import 'package:kites_news_app/src/core/network/web_service.dart';
import 'package:kites_news_app/src/core/utils/constant/network_constant.dart';
import 'package:kites_news_app/src/features/news/data/data_sources/remote/abstract_news_api.dart';
import 'package:kites_news_app/src/features/news/data/data_sources/remote/news_impl_api.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

import '../../../shared/fake_shared_preferences_store.dart';
import '../../../shared/test_injections.dart';
import 'category_mock_data/actual_news_category_json.dart';
import 'category_mock_data/expected_news_category_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.I.reset();
  SharedPreferencesAsyncPlatform.instance = FakeSharedPreferencesAsync();
  SharedPreferences.setMockInitialValues({});
  await testInitInjections();

  late DioNetwork mockDio;
  late ApiService apiService;
  late AbstractNewsApi newsApi;

  setUpAll(() async {
    mockDio = sl<DioNetwork>();
    apiService = sl<ApiService>();

    newsApi = NewsImplApi(apiService);
  });

  tearDownAll(() {
    SharedPreferencesAsyncPlatform.instance = null;
  });
  RequestOptions requestOptions = RequestOptions(headers: Helper.getHeaders());

  group("Test news_impl_api", () {
    test("Get All Categories - Failed Case", () async {
      // Mockito will store the fake call to `fakeCall`, and pair the exact
      // arguments given with the response. When `fakeCall` is called outside a
      // `when` or `verify` context (a call "for real"), Mockito will respond with
      // the stored canned response, if it can match the mock method parameters.
      when(mockDio.get(getListOfCategories())).thenAnswer((realInvocation) async {
        // Actual result
        return Response(requestOptions: requestOptions, statusCode: 400);
      });
      var result;
      try {
        result = await newsApi.getListOfCategory();
      } catch (e) {
        result = e;
      }
      // Compare actual result with expected result
      expect(result, ServerException("Unknown Error", 400));
    });

    test("Get All Categories - Empty Case", () async {
      when(mockDio.get(getListOfCategories())).thenAnswer((realInvocation) async {
        // Actual result
        return Response(
          requestOptions: requestOptions,
          statusCode: 200,
          data: actualEmptyCategoryJson,
        );
      });
      var result;
      try {
        // Compare actual result with expected result
        result = await newsApi.getListOfCategory();
      } catch (e) {
        result = e;
      }

      expect(result, expectedEmptyCategoryListData);
    });

    test("Get All Categories - List with category Case", () async {
      when(mockDio.get(getListOfCategories())).thenAnswer((realInvocation) async {
        // Actual result
        return Response(
          requestOptions: requestOptions,
          statusCode: 200,
          data: actualCategoryListJson,
        );
      });
      var result;
      try {
        // Compare actual result with expected result
        result = await newsApi.getListOfCategory();
      } catch (e) {
        result = e;
      }

      expect(result, expectedCategoryListData);
    });
  });
}
