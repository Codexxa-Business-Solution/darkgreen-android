// To parse this JSON data, do
//
//     final getSubCategoriesByIdResponseModel = getSubCategoriesByIdResponseModelFromJson(jsonString);

import 'dart:convert';

GetSubCategoriesByIdResponseModel getSubCategoriesByIdResponseModelFromJson(String str) => GetSubCategoriesByIdResponseModel.fromJson(json.decode(str));

String getSubCategoriesByIdResponseModelToJson(GetSubCategoriesByIdResponseModel data) => json.encode(data.toJson());

class GetSubCategoriesByIdResponseModel {
  GetSubCategoriesByIdResponseModel({
    required this.error,
    required this.message,
    required this.data,
  });

  bool error;
  String message;
  List<Datum> data;

  factory GetSubCategoriesByIdResponseModel.fromJson(Map<String, dynamic> json) => GetSubCategoriesByIdResponseModel(
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
    required this.categoryId,
    required this.name,
    required this.slug,
    required this.subtitle,
    required this.image,
    required this.categoryName,
  });

  String id;
  String rowOrder;
  String categoryId;
  String name;
  String slug;
  String subtitle;
  String image;
  String categoryName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    rowOrder: json["row_order"],
    categoryId: json["category_id"],
    name: json["name"],
    slug: json["slug"],
    subtitle: json["subtitle"],
    image: json["image"],
    categoryName: json["category_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "row_order": rowOrder,
    "category_id": categoryId,
    "name": name,
    "slug": slug,
    "subtitle": subtitle,
    "image": image,
    "category_name": categoryName,
  };
}
