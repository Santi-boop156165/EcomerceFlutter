// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));



class CategoriesModel {
  List<Category> categories;

  CategoriesModel({
    required this.categories,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );


}

class Category {
  String name;
  List<String> subcategories;

  Category({
    required this.name,
    required this.subcategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json["name"],
    subcategories: List<String>.from(json["subcategories"].map((x) => x)),
  );


}
