// To parse this JSON data, do
//
//     final getContactResponseModel = getContactResponseModelFromJson(jsonString);

import 'dart:convert';

GetContactResponseModel getContactResponseModelFromJson(String str) =>
    GetContactResponseModel.fromJson(json.decode(str));

String getContactResponseModelToJson(GetContactResponseModel data) =>
    json.encode(data.toJson());

class GetContactResponseModel {
  String error;
  String contact;

  GetContactResponseModel({
    required this.error,
    required this.contact,
  });

  factory GetContactResponseModel.fromJson(Map<String, dynamic> json) =>
      GetContactResponseModel(
        error: json["error"],
        contact: json["contact"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "contact": contact,
      };
}
