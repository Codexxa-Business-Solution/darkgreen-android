// To parse this JSON data, do
//
//     final sliderImageResponseModel = sliderImageResponseModelFromJson(jsonString);

import 'dart:convert';

SliderImageResponseModel sliderImageResponseModelFromJson(String str) => SliderImageResponseModel.fromJson(json.decode(str));

String sliderImageResponseModelToJson(SliderImageResponseModel data) => json.encode(data.toJson());

class SliderImageResponseModel {
  SliderImageResponseModel({
    required this.error,
    required this.message,
    required this.data,
  });

  bool error;
  String message;
  List<Datum> data;

  factory SliderImageResponseModel.fromJson(Map<String, dynamic> json) => SliderImageResponseModel(
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
    required this.type,
    required this.typeId,
    required this.name,
    required this.slug,
    required this.sliderUrl,
    required this.title,
    required this.shortDescription,
    required this.image,
    required this.image2,
  });

  String type;
  String typeId;
  String name;
  String slug;
  String sliderUrl;
  String title;
  String shortDescription;
  String image;
  String image2;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    type: json["type"],
    typeId: json["type_id"],
    name: json["name"],
    slug: json["slug"],
    sliderUrl: json["slider_url"],
    title: json["title"],
    shortDescription: json["short_description"],
    image: json["image"],
    image2: json["image2"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "type_id": typeId,
    "name": name,
    "slug": slug,
    "slider_url": sliderUrl,
    "title": title,
    "short_description": shortDescription,
    "image": image,
    "image2": image2,
  };
}
