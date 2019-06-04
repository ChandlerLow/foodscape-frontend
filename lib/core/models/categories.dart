import 'package:flutter/material.dart';
import 'package:frontend/core/models/category.dart';
import 'package:frontend/ui/shared/food_icons.dart';

final Map<int, Category> defaultCategories = <int, Category>{
  0: Category(1, 'Fruits', FoodIcons.diet, color: const Color(0xFFEE5731)),
  1: Category(2, 'Vegetables', FoodIcons.salad, color: const Color(0xFF3CEE89)),
  2: Category(3, 'Meats', FoodIcons.meat, color: const Color(0xFFD93872)),
  3: Category(4, 'Dairy & Eggs', FoodIcons.milk,
      color: const Color(0xFF8CDCEF)),
  4: Category(5, 'Cereals', FoodIcons.wheat, color: const Color(0xFF7DEB94)),
  5: Category(6, 'Confectionery', FoodIcons.cupcake,
      color: const Color(0xFFE160B2)),
  6: Category(0, 'Uncategorised', FoodIcons.fork,
      color: const Color(0xFFC2C4C8)),
};
