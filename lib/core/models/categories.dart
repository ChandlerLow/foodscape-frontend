import 'package:flutter/material.dart';
import 'package:frontend/core/models/category.dart';
import 'package:frontend/ui/shared/food_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<int, Category> defaultCategories = <int, Category>{
  2: Category(2, 'Fruits', 'fruits', FoodIcons.diet,
      color: const Color(0xFFEE5731)),
  3: Category(3, 'Vegetables', 'vegetables', FoodIcons.salad,
      color: const Color(0xFF3CEE89)),
  4: Category(4, 'Meats', 'meats', FoodIcons.meat,
      color: const Color(0xFFD93872)),
  5: Category(5, 'Dairy & Eggs', 'dairy_and_eggs', FoodIcons.milk,
      color: const Color(0xFF8CDCEF)),
  6: Category(6, 'Cereals', 'cereals', FoodIcons.wheat,
      color: const Color(0xFF7DEB94)),
  7: Category(7, 'Confectionery', 'confectionery', FoodIcons.cupcake,
      color: const Color(0xFFE160B2)),
  1: Category(1, 'Uncategorised', 'uncategorised', FoodIcons.fork,
      color: const Color(0xFFC2C4C8)),
};

class UserCategories {
  final Map<int, Category> _categories = defaultCategories;

  Future<void> populateUserSelections() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    for (int i in defaultCategories.keys) {
      _categories[i].isSelected =
          _prefs.containsKey('cat_${_categories[i].slug}')
              ? _prefs.getBool('cat_${_categories[i].slug}')
              : true;
    }
  }

  Future<void> persistUserSelections() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    for (int i in defaultCategories.keys) {
      await _prefs.setBool(
        'cat_${_categories[i].slug}',
        _categories[i].isSelected,
      );
    }
  }

  Future<void> persistCategorySelected(int id, bool isSelected) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool(
      'cat_${_categories[id].slug}',
      isSelected,
    );
  }

  Map<int, Category> getCategories() {
    return _categories;
  }

  Map<int, Category> getSelectedCategories() {
    return Map<int, Category>.from(_categories)
      ..removeWhere((_, Category v) => !v.isSelected);
  }
}
