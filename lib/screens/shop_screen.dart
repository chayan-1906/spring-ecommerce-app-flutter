import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';

class ShopScreen extends StatefulWidget {
  final List<CategoryModel> categories;
  final List<ProductModel> products;

  const ShopScreen({
    Key key,
    @required this.categories,
    @required this.products,
  }) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop')),
      /*https://youtu.be/uUpB9l3aFZ4?list=PLbtI3_MArDOlnBkBS-O04_YNIaZG4yetn&t=546,
      Design: https://youtu.be/uUpB9l3aFZ4?list=PLbtI3_MArDOlnBkBS-O04_YNIaZG4yetn&t=454
      // TODO: HAVE TO FILTER PRODUCTS BASED ON CATEGORIES

      Design: https://youtu.be/uUpB9l3aFZ4?list=PLbtI3_MArDOlnBkBS-O04_YNIaZG4yetn&t=1003
      // TODO: HAVE TO SHOW THE PRODUCT DETAILS IN A NEW SCREEN*/
      //   body: ,
    );
  }
}
