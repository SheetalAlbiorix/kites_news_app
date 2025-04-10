import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kites_news_app/src/features/news/presentation/pages/news_page.dart';
import 'package:kites_news_app/src/shared/presentation/pages/photo_view_page.dart';
import 'package:kites_news_app/src/shared/presentation/pages/web_view_page.dart';

import '../../features/articles/domain/models/article_model.dart';
import '../../features/articles/presentation/pages/article_details_page.dart';


class AppRouter {
  static String currentRoute = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    currentRoute = settings.name ?? "/";
    switch (settings.name) {
      // Ny Times Articles page
      case '/news_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const NewsPage(),
        );

      // Ny Times Article Details page
      case '/article_details_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) {
            assert(
                settings.arguments != null, "nyTimesArticleModel is required");
            return ArticleDetailsPage(
              model: settings.arguments as ArticleModel,
            );
          },
        );

      // Web view page
      case '/web_view_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => WebViewPage(
            link: settings.arguments as String,
          ),
        );

      // Photo view page
      case '/photo_view_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) {
            Map<String, dynamic>? args =
                settings.arguments as Map<String, dynamic>?;
            assert(args != null, "You should pass 'path' and 'fromNet'");
            return PhotoViewPage(
              path: args!['path'],
              fromNet: args['fromNet'],
            );
          },
        );

      default:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
