// To parse this JSON data, do
//
//     final getAddressRemoveResponseModel = getAddressRemoveResponseModelFromJson(jsonString);

import 'dart:convert';

GetAddressRemoveResponseModel getAddressRemoveResponseModelFromJson(String str) => GetAddressRemoveResponseModel.fromJson(json.decode(str));

String getAddressRemoveResponseModelToJson(GetAddressRemoveResponseModel data) => json.encode(data.toJson());

class GetAddressRemoveResponseModel {
  GetAddressRemoveResponseModel({
    required this.error,
    required this.message,
  });

  bool error;
  String message;

  factory GetAddressRemoveResponseModel.fromJson(Map<String, dynamic> json) => GetAddressRemoveResponseModel(
    error: json["error"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
  };
}
