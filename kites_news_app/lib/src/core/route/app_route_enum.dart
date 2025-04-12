enum AppRouteEnum {
  newsPage,
  articleDetailsPage,
  weViewPage,
  photoViewPage,
  newsDetailPage,

  articleDetailPage
}

extension AppRouteExtension on AppRouteEnum {
  String get name {
    switch (this) {
      case AppRouteEnum.newsPage:
        return "/news_page";

      case AppRouteEnum.articleDetailsPage:
        return "/article_details_page";

      case AppRouteEnum.weViewPage:
        return "/web_view_page";

      case AppRouteEnum.photoViewPage:
        return "/photo_view_page";

      case AppRouteEnum.newsDetailPage:
        return "/news_detail_page";
      case AppRouteEnum.articleDetailPage:
        return "/article_detail_page";
    }
  }
}
