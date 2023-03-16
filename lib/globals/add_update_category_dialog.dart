import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spring_ecommerce_app/models/category_model.dart';

import '../apis/apis.dart';
import '../screens/all_categories_screen.dart';

void showAddUpdateCategoryDialog({
  @required BuildContext context,
  CategoryModel category, // for updating purpose
  Function fetchCategories,
}) {
  TextEditingController categoryNameController = TextEditingController(
      text: category != null ? category.categoryName : '');
  String errorText = '';
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(builder: (context, alertSetState) {
        return AlertDialog(
          title: const Text('Add Category'),
          titlePadding: const EdgeInsets.all(20.0),
          contentPadding: const EdgeInsets.all(12.0),
          content: TextFormField(
            controller: categoryNameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Category Name',
              hintText: 'Category name...',
              errorText: errorText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Theme.of(context).errorColor,
                  width: 2.0,
                ),
              ),
            ),
            onChanged: (String value) {
              if (value.isEmpty) {
                alertSetState(() {
                  errorText = 'Category name is required...';
                });
              } else {
                alertSetState(() {
                  errorText = '';
                });
              }
            },
          ),
          actions: [
            /// cancel
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),

            /// add
            ElevatedButton(
              onPressed: () {
                if (categoryNameController.text.isEmpty) {
                  alertSetState(() {
                    errorText = 'Category name is required...';
                  });
                  return;
                }
                if (category == null) {
                  addCategoryApi(
                    context: context,
                    requestBody: {'name': categoryNameController.text},
                  ).then((value) {
                    Navigator.pop(context);
                    if (fetchCategories == null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const AllCategoriesScreen();
                        }),
                      );
                    } else {
                      fetchCategories();
                    }
                  });
                } else {
                  updateCategoryApi(
                    context: context,
                    categoryID: category.categoryID,
                    requestBody: {'name': categoryNameController.text},
                  ).then((value) {
                    Navigator.pop(context);
                    fetchCategories();
                  });
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      });
    },
  );
}
