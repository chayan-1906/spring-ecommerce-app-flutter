import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spring_ecommerce_app/globals/add_update_category_dialog.dart';
import 'package:spring_ecommerce_app/models/product_model.dart';
import 'package:spring_ecommerce_app/screens/all_categories_screen.dart';

import '../models/category_model.dart';

const String BASE_URL = "http://localhost:8090";

Map<String, String> buildHeader() {
  return {
    "Access-Control-Allow-Origin": "*", // Required for CORS support to work
    "Access-Control-Allow-Credentials":
        "true", // Required for cookies, authorization headers with HTTPS
    "Access-Control-Allow-Headers":
        "Access-Control-Allow-Origin,Accept,Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale,X-Auth-Token",
    "Access-Control-Allow-Methods": "GET, POST, OPTIONS, PUT, DELETE",
    'Content-Type': 'application/json; charset=UTF-8',
  };
}

/// CATEGORY APIS
Future<List<CategoryModel>> getAllCategoriesApi(
    {@required BuildContext context}) async {
  print('getCategoriesApi called');
  http.Response response;
  List<CategoryModel> categories = [];
  try {
    Uri uri = Uri.parse('$BASE_URL/admin/categories');
    response = await http.get(uri, headers: buildHeader());
    print('getCategoriesApi status code : ${response.statusCode}');
    print('getCategoriesApi response body : ${response.body}');
    if (response.statusCode == 200) {
      for (var body in json.decode(response.body)) {
        CategoryModel category = CategoryModel.fromJson(body);
        categories.add(category);
      }
    }
  } catch (error) {
    print('Inside catch getCategoriesApi : $error');
  }
  return categories;
}

Future<http.Response> addCategoryApi({
  @required BuildContext context,
  @required Map<String, dynamic> requestBody,
}) async {
  print('addCategoryApi called');
  http.Response response;
  try {
    Uri uri = Uri.parse('$BASE_URL/admin/categories');
    response = await http.post(
      uri,
      headers: buildHeader(),
      body: json.encode(requestBody),
    );
    print('addCategoryApi status code : ${response.statusCode}');
    print('addCategoryApi response body: ${response.body}');
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Category added successfully')),
      );
    }
  } catch (error) {
    print('Inside catch addCategoryApi : $error');
  }
  return response;
}

Future<http.Response> updateCategoryApi({
  @required BuildContext context,
  @required String categoryID,
  @required Map<String, dynamic> requestBody,
}) async {
  print('updateCategoryApi called');
  http.Response response;
  try {
    Uri uri = Uri.parse('$BASE_URL/admin/categories/$categoryID');
    response = await http.put(
      uri,
      headers: buildHeader(),
      body: jsonEncode(requestBody),
    );
    print('updateCategoryApi status code : ${response.statusCode}');
    print('updateCategoryApi response body: ${response.body}');
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Category with $categoryID updated successfully'),
        ),
      );
    }
  } catch (error) {
    print('Inside catch updateCategoryApi : $error');
  }
  return response;
}

Future<http.Response> deleteCategoryApi({
  @required BuildContext context,
  @required String categoryID,
}) async {
  print('deleteCategoryApi called');
  http.Response response;
  try {
    Uri uri = Uri.parse('$BASE_URL/admin/categories/$categoryID');
    response = await http.delete(uri, headers: buildHeader());
    print('deleteCategoryApi status code : ${response.statusCode}');
    print('deleteCategoryApi response body: ${response.body}');
  } catch (error) {
    print('Inside catch deleteCategoryApi : $error');
  }
  return response;
}

/// PRODUCT APIS
Future<List<ProductModel>> getAllProductsApi({
  @required BuildContext context,
}) async {
  print('getAllProductsApi called');
  http.Response response;
  List<ProductModel> products = [];
  try {
    Uri uri = Uri.parse('$BASE_URL/admin/products');
    response = await http.get(uri, headers: buildHeader());
    print('getAllProductsApi status code : ${response.statusCode}');
    print('getAllProductsApi response body : ${response.body}');
    if (response.statusCode == 200) {
      for (var body in json.decode(response.body)) {
        ProductModel product = ProductModel.fromJson(body);
        products.add(product);
      }
    }
  } catch (error) {
    print('Inside catch getAllProductsApi : $error');
  }
  return products;
}

Future<http.Response> addProductApi({
  @required BuildContext context,
  @required Map<String, dynamic> requestBody,
}) async {
  print('addProductApi called');
  http.Response response;
  try {
    Uri uri = Uri.parse('$BASE_URL/admin/products');
    print(jsonEncode(requestBody));
    response = await http.post(
      uri,
      headers: buildHeader(),
      body: json.encode(requestBody),
    );
    print('addProductApi status code : ${response.statusCode}');
    print('addProductApi response body: ${response.body}');
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully')),
      );
    }
  } catch (error) {
    print('Inside catch addProductApi : $error');
  }
  return response;
}

Future<http.Response> updateProductApi({
  @required BuildContext context,
  @required String productID,
  @required Map<String, dynamic> requestBody,
}) async {
  print('updateProductApi called');
  http.Response response;
  try {
    Uri uri = Uri.parse('$BASE_URL/admin/products/$productID');
    print(jsonEncode(requestBody));
    response = await http.put(
      uri,
      headers: buildHeader(),
      body: json.encode(requestBody),
    );
    print('updateProductApi status code : ${response.statusCode}');
    print('updateProductApi response body: ${response.body}');
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product updated successfully')),
      );
    }
  } catch (error) {
    print('Inside catch updateProductApi : $error');
  }
  return response;
}

Future<http.Response> deleteProductApi({
  @required BuildContext context,
  @required String productID,
}) async {
  print('deleteProductApi called');
  http.Response response;
  try {
    Uri uri = Uri.parse('$BASE_URL/admin/products/$productID');
    response = await http.delete(uri, headers: buildHeader());
    print('deleteProductApi status code : ${response.statusCode}');
    print('deleteProductApi response body: ${response.body}');
  } catch (error) {
    print('Inside catch deleteProductApi : $error');
  }
  return response;
}

/// UPLOAD FILE APIS
Future<String> uploadFileApi({@required File file}) async {
  print('uploadFileApi called');
  print(file);
  http.Response httpResponse;
  String responseImageID;
  try {
    var request =
        http.MultipartRequest('POST', Uri.parse('$BASE_URL/files/upload-file'));
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    http.StreamedResponse streamedResponse = await request.send();
    httpResponse = await http.Response.fromStream(streamedResponse);
    print('uploadFileApi status code : ${httpResponse.statusCode}');
    if (httpResponse.statusCode == 200) {
      responseImageID = httpResponse.body;
    }
    print('uploadFileApi response body : $responseImageID');
  } catch (error) {
    print('Inside catch uploadFileApi : $error');
  }
  return responseImageID;
}

Future<Uint8List> downloadFileApi({@required String fileID}) async {
  print('downloadFileApi called');
  http.Response response;
  Uint8List fileUInt8List;
  try {
    Uri uri = Uri.parse('$BASE_URL/files/$fileID');
    response = await http.get(uri, headers: buildHeader());
    print('downloadFileApi status code : ${response.statusCode}');
    print('downloadFileApi response body : ${response.body}');
  } catch (error) {
    print('Inside catch downloadFileApi : $error');
  }
  return fileUInt8List;
}
