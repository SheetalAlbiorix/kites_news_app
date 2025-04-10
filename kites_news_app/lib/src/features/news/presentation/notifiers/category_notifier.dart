import 'package:flutter/material.dart';
import 'package:kites_news_app/src/features/news/domain/models/list_of_category_model.dart';

class CategoryNotifier extends ChangeNotifier {
  Category? selectedCategory;

  Category? get getSelectedCategory => selectedCategory;

  void setSelectedCategory(Category? category) {
    selectedCategory = category;
    notifyListeners();
  }
}
