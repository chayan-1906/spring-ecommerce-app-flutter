import 'package:flutter/material.dart';
import 'package:spring_ecommerce_app/apis/apis.dart';
import 'package:spring_ecommerce_app/globals/add_update_category_dialog.dart';
import 'package:spring_ecommerce_app/globals/global_and_constants.dart';

import '../models/category_model.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({Key key}) : super(key: key);

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  bool isLoading = false;
  List<CategoryModel> categories = [];

  Future<void> fetchCategories() async {
    setState(() {
      isLoading = true;
    });
    categories = await getAllCategoriesApi(context: context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
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
                        onPressed: () => showAddUpdateCategoryDialog(
                          context: context,
                          fetchCategories: fetchCategories,
                        ),
                        child: const Text('Add Category'),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => const Color(0xFFECECEC)),
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

                        /// category name
                        DataColumn(
                          label: Text(
                            'Category Name',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                            ),
                          ),
                        ),

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
                      rows: categories
                          .map(
                            (category) => DataRow(
                              cells: [
                                /// category id
                                DataCell(Text(category.categoryID)),

                                /// category name
                                DataCell(Text(category.categoryName)),

                                /// delete
                                DataCell(
                                  ElevatedButton(
                                    onPressed: () {
                                      deleteCategoryApi(
                                        context: context,
                                        categoryID: category.categoryID,
                                      ).then((response) {
                                        if (response.statusCode == 200) {
                                          fetchCategories();
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
                                      showAddUpdateCategoryDialog(
                                        context: context,
                                        category: category,
                                        fetchCategories: fetchCategories,
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
