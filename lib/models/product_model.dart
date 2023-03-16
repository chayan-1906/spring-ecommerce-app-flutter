import 'package:spring_ecommerce_app/models/category_model.dart';

class ProductModel {
  String productID;
  String productName;
  CategoryModel productCategory;
  double productPrice;
  double productWeight;
  String productDescription;
  String productImageName;

  ProductModel({
    this.productID,
    this.productName,
    this.productCategory,
    this.productPrice,
    this.productWeight,
    this.productDescription,
    this.productImageName,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productID: json['id'],
      productName: json['name'],
      productCategory: CategoryModel.fromJson(json['category']),
      productPrice: json['price'],
      productWeight: json['weight'],
      productDescription: json['description'],
      productImageName: json['imageName'],
    );
  }

  @override
  String toString() {
    return 'ProductModel{productID: $productID, productName: $productName, categories: $productCategory, productPrice: $productPrice, productHeight: $productWeight, productDescription: $productDescription, productImageName: $productImageName}';
  }
}
