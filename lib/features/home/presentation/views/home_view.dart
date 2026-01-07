


import 'package:ecommerce_app_project/features/home/data/data_sources/categories_data.dart';
import 'package:ecommerce_app_project/features/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app_project/features/home/presentation/views/all_categories_view.dart';
import 'package:ecommerce_app_project/features/home/presentation/widgets/bottom_nav.dart';
import 'package:ecommerce_app_project/features/home/presentation/widgets/categories_header.dart';
import 'package:ecommerce_app_project/features/home/presentation/widgets/categories_strip.dart';
import 'package:ecommerce_app_project/features/home/presentation/widgets/featured_product_card.dart';
import 'package:ecommerce_app_project/features/home/presentation/widgets/filter_button.dart';
import 'package:ecommerce_app_project/features/home/presentation/widgets/search_field.dart';
import 'package:ecommerce_app_project/features/home/presentation/widgets/top_bar.dart';
import 'package:ecommerce_app_project/features/products/data/repos/products_repo.dart';
import 'package:ecommerce_app_project/features/products/domain/entities/product_entity.dart';
import 'package:ecommerce_app_project/features/products/presentation/views/featured_products_view.dart';
import 'package:ecommerce_app_project/features/products/presentation/views/product_detailes_view.dart';
import 'package:ecommerce_app_project/features/products/presentation/widget/product_card.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const String routeName = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedCategory = 0; // index داخل كل categories

  bool showAllCategories = false;

  final List<CategoryEntity> categories = CategoriesData.list;

  // ✅ فقط 4 للهوم
  List<CategoryEntity> get homeCategories => categories.take(4).toList();

  int get homeSelectedIndex {
    if (categories.isEmpty) return -1;
    final selectedId = categories[selectedCategory].id;
    return homeCategories.indexWhere((c) => c.id == selectedId);
  }

  void _onHomeCategoryTap(int homeIndex) {
    final id = homeCategories[homeIndex].id;
    final fullIndex = categories.indexWhere((c) => c.id == id);
    if (fullIndex == -1) return;
    setState(() => selectedCategory = fullIndex);
  }

  void _selectCategoryByIdNoSetState(String id) {
    final index = categories.indexWhere((c) => c.id == id);
    if (index == -1) return;
    selectedCategory = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Stack(
          children: [
            // Home content
            Visibility(
              visible: !showAllCategories,
              maintainState: true,
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TopBar(),
                    const SizedBox(height: 10),
                    const Text(
                      'Welcome,',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'GreatVibes',
                        fontSize: 50,
                        height: 1.0,
                      ),
                    ),
                    const Text(
                      'Our Fashions App',
                      style: TextStyle(fontSize: 24, height: 1.0),
                    ),
                    const SizedBox(height: 50),

                    Row(
                      children: const [
                        Expanded(child: SearchField()),
                        SizedBox(width: 12),
                        FilterButton(),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // ✅ الكارد الثابت (زي ما بدك)
                    const FeaturedProductCard(
                      imageUrl: 'assets/images/shoes.jpeg',
                      title: 'Axel Arigato',
                      subtitle: 'Clean 90 Triple Sneakers',
                      price: '\$245.00',
                    ),

                    const SizedBox(height: 30),

                    CategoriesHeader(
                      title: 'Categories',
                      onViewAll: () => setState(() => showAllCategories = true),
                    ),
                    const SizedBox(height: 10),

                    CategoriesStrip(
                      categories: homeCategories,
                      selectedIndex: homeSelectedIndex,
                      onSelect: _onHomeCategoryTap,
                    ),

                    const SizedBox(height: 22),

                    // ✅ Featured header + See more
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Featured',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, FeaturedProductsView.routeName);
                          },
                          child: const Text(
                            'See more',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ✅ منتجات مختارة للهوم من Firebase
                    StreamBuilder<List<ProductEntity>>(
                      stream: ProductsRepo().streamHomeProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        final items = snapshot.data ?? [];
                        if (items.isEmpty) {
                          return const Text('No featured items for home');
                        }

                        // ✅ Grid صغير داخل سكرول الصفحة
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                            childAspectRatio: 0.60,
                          ),
                          itemBuilder: (context, index) {
                            final product = items[index];

                            return ProductCard(
                              product: product,
                              showRating: false, // ✅ بدون نجمة بالهوم
                              showSubtitle: true, // ✅ subtitle يظهر
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  ProductDetailsView.routeName,
                                  arguments: product,
                                );
                              },
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // All Categories overlay
            Visibility(
              visible: showAllCategories,
              maintainState: true,
              child: AllCategoriesView(
                onBack: () => setState(() => showAllCategories = false),
                categories: categories,
                onSelectCategory: (cat) {
                  setState(() {
                    showAllCategories = false;
                    _selectCategoryByIdNoSetState(cat.id);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    
    );
  }
}
