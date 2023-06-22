// To parse this JSON data, do
//
//     final getAboutUsResponseModel = getAboutUsResponseModelFromJson(jsonString);

import 'dart:convert';

GetAboutUsResponseModel getAboutUsResponseModelFromJson(String str) =>
    GetAboutUsResponseModel.fromJson(json.decode(str));

String getAboutUsResponseModelToJson(GetAboutUsResponseModel data) =>
    json.encode(data.toJson());

class GetAboutUsResponseModel {
  bool error;
  String about;

  GetAboutUsResponseModel({
    required this.error,
    required this.about,
  });

  factory GetAboutUsResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAboutUsResponseModel(
        error: json["error"],
        about: json["about"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "about": about,
      };
}
