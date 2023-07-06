// To parse this JSON data, do
//
//     final changePasswordResponseModel = changePasswordResponseModelFromJson(jsonString);

import 'dart:convert';

ChangePasswordResponseModel changePasswordResponseModelFromJson(String str) =>
    ChangePasswordResponseModel.fromJson(json.decode(str));

String changePasswordResponseModelToJson(ChangePasswordResponseModel data) =>
    json.encode(data.toJson());

class ChangePasswordResponseModel {
  String error;
  String message;

  ChangePasswordResponseModel({
    required this.error,
    required this.message,
  });

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      ChangePasswordResponseModel(
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
      };
}
