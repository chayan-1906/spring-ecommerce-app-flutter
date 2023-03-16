import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spring_ecommerce_app/globals/global_and_constants.dart';
import 'package:spring_ecommerce_app/models/category_model.dart';
import 'package:spring_ecommerce_app/models/product_model.dart';

import '../apis/apis.dart';
import '../screens/all_products_screen.dart';

void showAddUpdateProductDialog({
  @required BuildContext context,
  @required List<CategoryModel> availableCategories,
  @required List<ProductModel> availableProducts,
  ProductModel productModel, // for updating purpose
  Function fetchProducts,
}) {
  TextEditingController productNameController = TextEditingController(
      text: productModel != null ? productModel.productName : '');
  CategoryModel selectedCategory;
  if (productModel != null) {
    for (CategoryModel category in availableCategories) {
      if (category.categoryID == productModel.productCategory.categoryID) {
        selectedCategory = category;
        break;
      }
    }
  }
  TextEditingController productPriceController = TextEditingController(
      text: productModel != null
          ? productModel.productPrice.toString().split('.')[0]
          : '');
  TextEditingController productWeightController = TextEditingController(
      text: productModel != null
          ? productModel.productWeight.toString().split('.')[0]
          : '');
  TextEditingController productDescriptionController = TextEditingController(
      text: productModel != null ? productModel.productDescription : '');
  ImagePicker imagePicker = ImagePicker();
  XFile productImage;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(builder: (context, alertSetState) {
        return AlertDialog(
          title: const Text('Add Product'),
          titlePadding: const EdgeInsets.all(20.0),
          contentPadding: const EdgeInsets.all(20.0),
          content: Container(
            width: MediaQuery.of(context).size.width,
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 5.0),

                /// product name textformfield
                TextFormField(
                  controller: productNameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    hintText: 'Product name...',
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
                  ),
                  onChanged: (String value) {
                    if (value.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('All fields are required')));
                    }
                  },
                ),
                const SizedBox(height: 10.0),

                /// product category
                FormField<CategoryModel>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  enabled: true,
                  builder: (FormFieldState<CategoryModel> state) {
                    return DropdownButton<CategoryModel>(
                      value: selectedCategory,
                      hint: const Text('Category'),
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(15.0),
                      items: availableCategories.map((availableCategory) {
                        return DropdownMenuItem<CategoryModel>(
                          value: availableCategory,
                          child: Text(availableCategory.categoryName),
                        );
                      }).toList(),
                      onChanged: (value) {
                        alertSetState(() {
                          selectedCategory = value;
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 10.0),

                /// product price
                TextFormField(
                  controller: productPriceController,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Product price',
                    hintText: 'Product price...',
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
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('All fields are required')));
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r"^-?\d*\.?\d{0," + "${2}" + "}")),
                  ],
                ),
                const SizedBox(height: 10.0),

                /// product weight
                TextFormField(
                  controller: productWeightController,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Product weight',
                    hintText: 'Product weight...',
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
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('All fields are required')));
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r"^-?\d*\.?\d{0," + "${2}" + "}")),
                  ],
                ),
                const SizedBox(height: 10.0),

                /// product description
                TextFormField(
                  controller: productDescriptionController,
                  keyboardType: TextInputType.text,
                  maxLines: 10,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Product description',
                    hintText: 'Product description...',
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
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('All fields are required')));
                    }
                  },
                ),
                const SizedBox(height: 10.0),

                /// product image
                /*Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: productImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.file(
                            File(productImage.path),
                            fit: BoxFit.cover,
                          ),
                        )
                      : IconButton(
                          icon: const Icon(Icons.image, size: 100.0),
                          color: Colors.grey.shade500,
                          onPressed: () async {
                            productImage = await imagePicker.pickImage(
                              source: ImageSource.gallery,
                              maxHeight: 2048,
                              maxWidth: 2048,
                            );
                            alertSetState(() {});
                          },
                        ),
                ),
                const SizedBox(height: 10.0),*/
              ],
            ),
          ),
          actions: [
            /// cancel
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),

            /// add / update
            ElevatedButton(
              onPressed: () {
                if (productNameController.text.isEmpty ||
                    selectedCategory == null ||
                    productPriceController.text.isEmpty ||
                    productWeightController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('All fields are required')));
                  return;
                }
                if (productModel == null) {
                  /*uploadFileApi(file: File(productImage.path))
                      .then((uploadedImageResponse) {
                  });*/
                  addProductApi(
                    context: context,
                    requestBody: {
                      'name': productNameController.text,
                      'category': selectedCategory.toMap(),
                      'price': productPriceController.text != ''
                          ? double.parse(productPriceController.text)
                          : 0,
                      'weight': productWeightController.text != ''
                          ? double.parse(productWeightController.text)
                          : 0,
                      'description': productDescriptionController.text,
                      'imageName':
                          productImage != null ? productImage.path : '',
                    },
                  ).then((value) async {
                    Navigator.pop(context);
                    if (fetchProducts == null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return AllProductsScreen(
                            categories: availableCategories,
                            products: availableProducts,
                          );
                        }),
                      );
                    } else {
                      fetchProducts();
                    }
                  });
                } else {
                  updateProductApi(
                    context: context,
                    productID: productModel.productID,
                    requestBody: {
                      'id': productModel.productID,
                      'name': productNameController.text,
                      'category': selectedCategory.toMap(),
                      'price': productPriceController.text != ''
                          ? double.parse(productPriceController.text)
                          : 0,
                      'weight': productWeightController.text != ''
                          ? double.parse(productWeightController.text)
                          : 0,
                      'description': productDescriptionController.text,
                      'imageName':
                          productImage != null ? productImage.path : '',
                    },
                  ).then((value) {
                    Navigator.pop(context);
                    fetchProducts();
                  });
                }
              },
              child: Text(productModel == null ? 'Add' : 'Update'),
            ),
          ],
        );
      });
    },
  );
}
