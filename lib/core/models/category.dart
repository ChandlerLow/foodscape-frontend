import 'package:flutter/widgets.dart';

class Category {
  Category(this.id, this.name, this.icon, {this.isSelected});

  final int id;
  final String name;
  final IconData icon;
  bool isSelected = true;
}
