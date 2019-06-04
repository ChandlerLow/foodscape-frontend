import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Category {
  Category(
    this.id,
    this.name,
    this.slug,
    this.icon, {
    this.color = Colors.black,
    this.isSelected = true,
  });

  final int id;
  final String name;
  final String slug;
  final IconData icon;
  final Color color;
  bool isSelected;
}
