import 'package:flutter/material.dart';
import 'package:spring_ecommerce_app/globals/add_update_product_dialog.dart';
import 'package:spring_ecommerce_app/globals/global_and_constants.dart';
import 'package:spring_ecommerce_app/models/product_model.dart';
import 'package:spring_ecommerce_app/screens/all_products_screen.dart';

import '../apis/apis.dart';
import '../globals/add_update_category_dialog.dart';
import '../models/category_model.dart';
import 'all_categories_screen.dart';
import 'shop_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ecommerce App')),
      body: ListView(
        children: [
          const SizedBox(height: 20.0),
          Text(
            'Welcome Back, Admin',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 40.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10.0),
          const Text(
            'Easily manage your data from this admin CMS',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(height: 30.0),

          /// categories
          Container(
            height: 150.0,
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(color: kAccentColor.withOpacity(0.4)),
            child: Column(
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    List<CategoryModel> categories =
                        await getAllCategoriesApi(context: context);
                    if (categories.isEmpty) {
                      showAddUpdateCategoryDialog(context: context);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const AllCategoriesScreen();
                        }),
                      );
                    }
                  },
                  child: const Text('Manage'),
                ),
              ],
            ),
          ),

          /// products
          Container(
            height: 150.0,
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(color: kAccentColor.withOpacity(0.4)),
            child: Column(
              children: [
                const Text(
                  'Products',
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    List<CategoryModel> categories =
                        await getAllCategoriesApi(context: context);
                    List<ProductModel> products =
                        await getAllProductsApi(context: context);
                    if (products.isEmpty) {
                      showAddUpdateProductDialog(
                        context: context,
                        availableCategories: categories,
                        availableProducts: products,
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return AllProductsScreen(
                            categories: categories,
                            products: products,
                          );
                        }),
                      );
                    }
                  },
                  child: const Text('Manage'),
                ),
              ],
            ),
          ),

          /// shop
          Container(
            height: 150.0,
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(color: kAccentColor.withOpacity(0.4)),
            child: Column(
              children: [
                const Text(
                  'Shop',
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    List<CategoryModel> categories =
                        await getAllCategoriesApi(context: context);
                    List<ProductModel> products =
                        await getAllProductsApi(context: context);
                    if (products.isEmpty) {
                      showAddUpdateProductDialog(
                        context: context,
                        availableCategories: categories,
                        availableProducts: products,
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return ShopScreen(
                            categories: categories,
                            products: products,
                          );
                        }),
                      );
                    }
                  },
                  child: const Text('Manage'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
