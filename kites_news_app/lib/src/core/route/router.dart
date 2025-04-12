import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kites_news_app/src/features/news/domain/models/category_response.dart';
import 'package:kites_news_app/src/features/news/presentation/notifiers/article_pagination_notifier.dart';
import 'package:kites_news_app/src/features/news/presentation/pages/article_detail_page.dart';
import 'package:kites_news_app/src/features/news/presentation/pages/news_detail_page.dart';
import 'package:kites_news_app/src/features/news/presentation/pages/news_page.dart';
import 'package:kites_news_app/src/shared/presentation/pages/photo_view_page.dart';
import 'package:kites_news_app/src/shared/presentation/pages/web_view_page.dart';
import 'package:provider/provider.dart';

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
            Map<String, dynamic>? args = settings.arguments as Map<String, dynamic>?;
            assert(args != null, "You should pass 'path' and 'fromNet'");
            return PhotoViewPage(
              path: args!['path'],
              fromNet: args['fromNet'],
            );
          },
        );

      case '/news_detail_page':
        assert(settings.arguments != null, "Cluster model is required");
        return _buildPageRouteWithArguments(
          NewsDetailPage(clusterModel: settings.arguments as Cluster),
          settings,
        );
      case '/article_detail_page':
        assert(settings.arguments != null, "Article model is required");
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (BuildContext context) {
            final articles = settings.arguments as Cluster;
            return ChangeNotifierProvider(
                create: (_) => ArticlePaginationProvider(allArticles: articles),
                child: ArticleDetailPage(articleList: settings.arguments as Cluster));
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

  // Function to build a page route with arguments
  static PageRouteBuilder _buildPageRouteWithArguments(
      Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: RouteSettings(name: settings.name),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Slide transition
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeIn;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
