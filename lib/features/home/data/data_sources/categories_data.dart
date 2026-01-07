import 'package:ecommerce_app_project/features/home/domain/entities/category_entity.dart';

import 'package:material_symbols_icons/material_symbols_icons.dart';


class CategoriesData {
  static const List<CategoryEntity> list = [
    CategoryEntity(
      id: 'new',
      title: 'New Arrivals',
      icon: Symbols.shopping_cart,
      count: 208,
    ),
    CategoryEntity(
      id: 'clothes',
      title: 'Clothes',
      icon: Symbols.apparel,
      count: 358,
    ),
    CategoryEntity(
      id: 'bags',
      title: 'Bags',
      icon: Symbols.shopping_bag,
      count: 160,
    ),
    CategoryEntity(
      id: 'shoes',
      title: 'Shoes',
      icon: Symbols.steps,
      count: 230,
    ),
    CategoryEntity(
      id: 'electronics',
      title: 'Electronics',
      icon: Symbols.devices,
      count: 130,
    ),
    CategoryEntity(
      id: 'jewelry',
      title: 'Jewelry',
      icon: Symbols.diamond
,


      count: 87,
    ),
  ];
}
