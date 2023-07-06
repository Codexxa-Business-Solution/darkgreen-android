// To parse this JSON data, do
//
//     final getBlogCatergoriesResponseModel = getBlogCatergoriesResponseModelFromJson(jsonString);

import 'dart:convert';

GetBlogCatergoriesResponseModel getBlogCatergoriesResponseModelFromJson(
        String str) =>
    GetBlogCatergoriesResponseModel.fromJson(json.decode(str));

String getBlogCatergoriesResponseModelToJson(
        GetBlogCatergoriesResponseModel data) =>
    json.encode(data.toJson());

class GetBlogCatergoriesResponseModel {
  String error;
  String message;
  String total;
  List<Datum> data;

  GetBlogCatergoriesResponseModel({
    required this.error,
    required this.message,
    required this.total,
    required this.data,
  });

  factory GetBlogCatergoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      GetBlogCatergoriesResponseModel(
        error: json["error"],
        message: json["message"],
        total: json["total"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "total": total,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String slug;
  String name;
  String image;
  String status;
  DateTime dateAdded;

  Datum({
    required this.id,
    required this.slug,
    required this.name,
    required this.image,
    required this.status,
    required this.dateAdded,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        image: json["image"],
        status: json["status"],
        dateAdded: DateTime.parse(json["date_added"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "name": name,
        "image": image,
        "status": status,
        "date_added": dateAdded.toIso8601String(),
      };
}
