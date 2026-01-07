import 'package:flutter/material.dart';

class CategoryEntity {
  const CategoryEntity({
    required this.id,
    required this.title,
    required this.icon,
    this.count,
  });

  final String id;
  final String title;
  final IconData icon;
  final int? count;
}
