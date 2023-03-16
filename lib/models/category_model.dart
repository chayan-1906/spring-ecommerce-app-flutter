class CategoryModel {
  String categoryID;
  String categoryName;

  CategoryModel({this.categoryID, this.categoryName});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(categoryID: json['id'], categoryName: json['name']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': categoryID,
      'name': categoryName,
    };
  }

  @override
  String toString() {
    return 'Category{categoryID: $categoryID, categoryName: $categoryName}';
  }
}
