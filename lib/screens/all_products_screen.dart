import 'dart:io';

import 'package:flutter/material.dart';
import 'package:spring_ecommerce_app/apis/apis.dart';
import 'package:spring_ecommerce_app/globals/global_and_constants.dart';
import 'package:spring_ecommerce_app/models/category_model.dart';
import 'package:spring_ecommerce_app/models/product_model.dart';
import 'package:spring_ecommerce_app/screens/product_details_screen.dart';

import '../globals/add_update_product_dialog.dart';

class AllProductsScreen extends StatefulWidget {
  final List<CategoryModel> categories;
  final List<ProductModel> products;

  const AllProductsScreen({
    Key key,
    @required this.categories,
    @required this.products,
  }) : super(key: key);

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  bool isLoading = false;
  List<CategoryModel> categories = [];
  List<ProductModel> products = [];
  List<CategoryModel> selectedCategories = [];
  List<ProductModel> filteredProducts = [];

  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
    });
    products = await getAllProductsApi(context: context);
    filteredProducts = products;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = widget.categories;
    products = widget.products;
    filteredProducts = products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...categories.map(
                        (category) => StatefulBuilder(
                            builder: (context, bottomSheetSetState) {
                          return CheckboxListTile(
                            value: selectedCategories.contains(category),
                            title: Text(category.categoryName),
                            activeColor: kPrimaryColor,
                            onChanged: (bool value) {
                              bottomSheetSetState(() {
                                if (value) {
                                  selectedCategories.add(category);
                                } else if (selectedCategories
                                    .contains(category)) {
                                  selectedCategories.remove(category);
                                } else {
                                  print('selectedCategory: $category');
                                }
                                print(
                                    'selectedCategories: $selectedCategories');
                              });
                            },
                          );
                        }),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          /// clear filter
                          ElevatedButton(
                            onPressed: () {
                              filteredProducts = products;
                              Navigator.pop(context);
                              selectedCategories = [];
                              setState(() {});
                            },
                            child: const Text('Clear'),
                          ),
                          const SizedBox(width: 10.0),

                          /// apply filter
                          ElevatedButton(
                            onPressed: () {
                              filteredProducts = [];
                              for (CategoryModel availableCategory
                                  in selectedCategories) {
                                filteredProducts.addAll(products.where(
                                    (product) =>
                                        product.productCategory.categoryID ==
                                        availableCategory.categoryID));
                              }
                              print('filteredProducts: $filteredProducts');
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: const Text('Apply'),
                          ),
                          const SizedBox(width: 20.0),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.filter_alt_rounded),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20.0),
                    Container(
                      margin: const EdgeInsets.only(left: 20.0),
                      child: ElevatedButton(
                        onPressed: () => showAddUpdateProductDialog(
                          context: context,
                          availableCategories: categories,
                          availableProducts: products,
                          fetchProducts: fetchProducts,
                        ),
                        child: const Text('Add Product'),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => const Color(0xFFECECEC)),
                      dataRowHeight: 150.0,
                      showCheckboxColumn: false,
                      columns: const [
                        /// id
                        DataColumn(
                          label: Text(
                            'ID',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                            ),
                          ),
                        ),

                        /// product name
                        DataColumn(
                          label: Text(
                            'Product Name',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                            ),
                          ),
                        ),

                        /// product category
                        DataColumn(
                          label: Text(
                            'Product Category',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                            ),
                          ),
                        ),

                        /// product price
                        DataColumn(
                          label: Text(
                            'Price',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                            ),
                          ),
                        ),

                        /// product weight
                        DataColumn(
                          label: Text(
                            'Weight',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                            ),
                          ),
                        ),

                        /// product description
                        DataColumn(
                          label: Text(
                            'Description',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                            ),
                          ),
                        ),

                        /// product preview
                        /*DataColumn(
                          label: Text(
                            'Preview',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                            ),
                          ),
                        ),*/

                        /// delete
                        DataColumn(
                          label: Text(
                            'Delete',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                            ),
                          ),
                        ),

                        /// update
                        DataColumn(
                          label: Text(
                            'Update',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                      rows: filteredProducts
                          .map(
                            (product) => DataRow(
                              onSelectChanged: (value) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return ProductDetailsScreen(
                                        productModel: product);
                                  }),
                                );
                              },
                              cells: [
                                /// product id
                                DataCell(
                                  Container(
                                    width: 60.0,
                                    child: Text(product.productID),
                                  ),
                                ),

                                /// product name
                                DataCell(Text(product.productName)),

                                /// product category
                                DataCell(
                                  Text(product.productCategory.categoryName),
                                ),

                                /// product price
                                DataCell(
                                  Text(
                                      '₹${product.productPrice.toString().split('.')[0]}'),
                                ),

                                /// product weight
                                DataCell(
                                  Text(
                                      '${product.productWeight.toString().split('.')[0]} gm'),
                                ),

                                /// product description
                                DataCell(
                                  product.productDescription != null
                                      ? Container(
                                          width: 100.0,
                                          child:
                                              Text(product.productDescription),
                                        )
                                      : '',
                                ),

                                /// product preview
                                /*DataCell(
                                  Container(
                                    width: 100.0,
                                    height: 100.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: product.productImageName != null
                                          ? Image.file(
                                              File(product.productImageName),
                                              fit: BoxFit.cover,
                                            )
                                          : const Icon(Icons.image_rounded),
                                    ),
                                  ),
                                  /*Container(
                                    width: 250.0,
                                    child: Text(
                                      maxLines: 3,
                                    ),
                                  ),*/
                                ),*/

                                /// delete
                                DataCell(
                                  ElevatedButton(
                                    onPressed: () {
                                      deleteProductApi(
                                        context: context,
                                        productID: product.productID,
                                      ).then((response) {
                                        if (response.statusCode == 200) {
                                          fetchProducts();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(response.body),
                                            ),
                                          );
                                        }
                                      });
                                    },
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),

                                /// update
                                DataCell(
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kSecondaryColor,
                                    ),
                                    onPressed: () {
                                      showAddUpdateProductDialog(
                                        context: context,
                                        productModel: product,
                                        fetchProducts: fetchProducts,
                                        availableCategories: categories,
                                        availableProducts: products,
                                      );
                                    },
                                    child: const Text(
                                      'Update',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
