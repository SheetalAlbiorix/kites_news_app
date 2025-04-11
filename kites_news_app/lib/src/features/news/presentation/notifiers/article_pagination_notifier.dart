import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kites_news_app/src/features/news/domain/models/category_response.dart';

class ArticlePaginationProvider with ChangeNotifier {
  final Cluster allArticles;
  List<Article> visibleArticles = [];
  bool isLoadingMore = false;
  int _visibleCount = 15;

  ArticlePaginationProvider({required this.allArticles}) {
    loadInitialArticles();
  }

  void loadInitialArticles() {
    visibleArticles = allArticles.articles!.take(_visibleCount).toList();
  }

  Future<void> loadMoreArticles() async {
    if (isLoadingMore || visibleArticles.length >= allArticles.articles!.length) return;

    isLoadingMore = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1)); // simulate delay

    _visibleCount = min(_visibleCount + 15, allArticles.articles?.length ?? 0);
    visibleArticles = allArticles.articles!.take(_visibleCount).toList();

    isLoadingMore = false;
    notifyListeners();
  }
}
