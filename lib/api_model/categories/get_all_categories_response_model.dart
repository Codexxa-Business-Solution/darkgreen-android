// To parse this JSON data, do
//
//     final getAllCategoriesResponseModel = getAllCategoriesResponseModelFromJson(jsonString);

import 'dart:convert';

GetAllCategoriesResponseModel getAllCategoriesResponseModelFromJson(String str) => GetAllCategoriesResponseModel.fromJson(json.decode(str));

String getAllCategoriesResponseModelToJson(GetAllCategoriesResponseModel data) => json.encode(data.toJson());

class GetAllCategoriesResponseModel {
  GetAllCategoriesResponseModel({
    required this.error,
    required this.message,
    required this.data,
  });

  bool error;
  String message;
  List<Datum> data;

  factory GetAllCategoriesResponseModel.fromJson(Map<String, dynamic> json) => GetAllCategoriesResponseModel(
    error: json["error"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.rowOrder,
    required this.name,
    required this.subtitle,
    required this.image,
    this.status,
    required this.webImage,
    required this.childs,
  });

  String id;
  String rowOrder;
  String name;
  String subtitle;
  String image;
  dynamic status;
  String webImage;
  Map<String, Child> childs;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    rowOrder: json["row_order"],
    name: json["name"],
    subtitle: json["subtitle"],
    image: json["image"],
    status: json["status"],
    webImage: json["web_image"],
    childs: Map.from(json["childs"]).map((k, v) => MapEntry<String, Child>(k, Child.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "row_order": rowOrder,
    "name": name,
    "subtitle": subtitle,
    "image": image,
    "status": status,
    "web_image": webImage,
    "childs": Map.from(childs).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class Child {
  Child({
    required this.id,
    required this.rowOrder,
    required this.categoryId,
    required this.name,
    required this.slug,
    required this.subtitle,
    required this.image,
  });

  String id;
  String rowOrder;
  String categoryId;
  String name;
  String slug;
  String subtitle;
  String image;

  factory Child.fromJson(Map<String, dynamic> json) => Child(
    id: json["id"],
    rowOrder: json["row_order"],
    categoryId: json["category_id"],
    name: json["name"],
    slug: json["slug"],
    subtitle: json["subtitle"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "row_order": rowOrder,
    "category_id": categoryId,
    "name": name,
    "slug": slug,
    "subtitle": subtitle,
    "image": image,
  };
}
