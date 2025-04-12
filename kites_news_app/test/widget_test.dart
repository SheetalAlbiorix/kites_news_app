// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kites_news_app/main.dart';
import 'package:kites_news_app/src/core/helper/helper.dart';
import 'package:kites_news_app/src/core/network/dio_network.dart';
import 'package:kites_news_app/src/core/utils/constant/network_constant.dart';
import 'package:kites_news_app/src/features/news/presentation/notifiers/NewsNotifier.dart';
import 'package:kites_news_app/src/features/news/presentation/pages/news_page.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'news/data/data_sources/category_mock_data/actual_news_category_json.dart';
import 'news/data/data_sources/clustor_mock_data/actual_news_category_json.dart';
import 'shared/helpers/test_setup.dart';
import 'shared/helpers/wrapper_widget.dart';

void main() async {
  RequestOptions requestOptions = RequestOptions(headers: Helper.getHeaders());

  late DioNetwork mockDio;

  setUpAll(() async {
    await initTestEnvironment();

    mockDio = sl<DioNetwork>();

    when(mockDio.get(getListOfCategories())).thenAnswer((realInvocation) async {
      // Actual result
      return Response(
        requestOptions: requestOptions,
        statusCode: 200,
        data: apiCategoryListJson,
      );
    });

    when(mockDio.get(getCategoryDetail('world.json'))).thenAnswer((realInvocation) async {
      // Actual result
      return Response(
        requestOptions: requestOptions,
        statusCode: 200,
        data: apiClusterListJson,
      );
    });
  });
  group(("News Page Test"), () {
    /// Verifies the text content of chips and cluster widgets within the NewsPage.
    ///
    /// This test checks the following:
    /// - Ensures the app renders with the 'Kite News' text.
    /// - Verifies that the 'USA' category widget, expected at the second position
    ///   according to the API response, matches the category name from the NewsNotifier.
    /// - Confirms that the 'Trump pauses global tariffs, markets rally' cluster widget
    ///   is at the first position as defined by the API response, with the title located
    ///   at the second position among the cluster card's three descendant texts.
    /// - Scrolls to the bottom of the cluster list to ensure all cluster widgets are
    ///   built and verifies that the total number of cluster widgets matches the
    ///   length of clusters in the NewsNotifier's newsCategoryResponse.
    /// - Expects the 'DOJ to deport alleged MS-13 leader instead of prosecution'
    ///   cluster widget to be at the last position as defined by the API response,
    ///   with its title located at the second position among the cluster card's
    ///   three descendant texts.
    testWidgets(
        """Verifies the text content of chips and cluster widgets within the NewsPage""",
        (WidgetTester tester) async {
      // Build our app and trigger a frame.

      await tester.pumpWidget(
        WrapperWidget(child: NewsPage()),
      );
      await tester.pumpAndSettle(Duration(seconds: 5));

      final newsNotifier = navigatorKey.currentContext?.read<NewsNotifier>();

      expect(find.text("Kite News"), findsOneWidget);

      final initialTextFinder = find.descendant(
        of: find.byKey(ValueKey("categoryChips_1")),
        matching: find.byType(Text),
      );
      final initialTextWidget = tester.widget<Text>(initialTextFinder);

      /// Expecting the 'USA' category widget at the
      /// 2nd position according to the API
      expect(
          newsNotifier?.newsResponse.data?.categories?[1].name, initialTextWidget.data);

      /// Expects the 'Trump pauses global tariffs, markets rally'
      /// cluster widget to be at the first position,
      /// as defined by the API response.
      final initialClusterTitleFinder = find.descendant(
        of: find.byKey(ValueKey("clusterKey_0")),
        matching: find.byType(Text),
      );

      /// Cluster cards have 3 descendant texts,
      /// with the title located at the second position.
      final initialClusterTextWidget =
          tester.widgetList<Text>(initialClusterTitleFinder).toList();

      expect(
          "Trump pauses global tariffs, markets rally", initialClusterTextWidget[1].data);
      expect(newsNotifier?.newsCategoryResponse.data?.clusters?[0].title,
          initialClusterTextWidget[1].data);

      /// Scroll to the bottom
      await tester.dragUntilVisible(
          find.text("DOJ to deport alleged MS-13 leader instead of prosecution"),
          find.byKey(ValueKey("clusterListKey")),
          Offset(0, -500));

      await tester.pumpAndSettle();

      /// Expects the 'DOJ to deport alleged MS-13 leader instead of prosecution'
      /// cluster widget to be at the last position,
      /// as defined by the API response.
      final lastCluster = newsNotifier!.newsCategoryResponse.data!.clusters!.length - 1;
      final lastClusterTitleFinder = find.descendant(
        of: find.byKey(ValueKey("clusterKey_${lastCluster}")),
        matching: find.byType(Text),
      );

      final lastClusterTextWidget =
          tester.widgetList<Text>(lastClusterTitleFinder).toList();

      expect(lastClusterTextWidget[1].data,
          "DOJ to deport alleged MS-13 leader instead of prosecution");
      expect(newsNotifier.newsCategoryResponse.data?.clusters?[lastCluster].title,
          lastClusterTextWidget[1].data);
    });

    /// Navigates to NewsDetailPage on cluster tap,
    /// verifies article title, scrolls to 'More Articles' section if 10+ articles exist.
    testWidgets(
        "Tapping on the Cluster should navigate to details page and expecting the articles",
        (WidgetTester tester) async {
      await tester.pumpWidget(
        WrapperWidget(child: NewsPage()),
      );
      await tester.pumpAndSettle(Duration(seconds: 5));

      await tester.tap(find.byKey(ValueKey("clusterKey_0")));

      await tester.pump(const Duration(milliseconds: 300)); // Navigation transition
      await tester.pump(const Duration(seconds: 1)); // First pass for initial build
      await tester.pump(const Duration(seconds: 1)); // Second pass for animations/images
      await tester.pumpAndSettle(Duration(minutes: 1));

      expect(find.text("Trump pauses global tariffs, markets rally"), findsOneWidget);

      await tester.dragUntilVisible(find.byKey(ValueKey("more_articles")),
          find.byKey(ValueKey("news_details_main_list")), Offset(0, -500));

      await tester.pumpAndSettle();
      final newsNotifier = navigatorKey.currentContext?.read<NewsNotifier>();

      /// More Articles widget only shows when there are more more then 10 articles presents
      expect(newsNotifier?.newsCategoryResponse.data?.clusters?[0].articles?.length,
          greaterThanOrEqualTo(10));

      expect(find.byKey(ValueKey("more_articles")), findsOneWidget);
    });
  });
}
