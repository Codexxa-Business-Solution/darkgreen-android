// To parse this JSON data, do
//
//     final userRegisterResponseModel = userRegisterResponseModelFromJson(jsonString);

import 'dart:convert';

UserRegisterResponseModel userRegisterResponseModelFromJson(String str) => UserRegisterResponseModel.fromJson(json.decode(str));

String userRegisterResponseModelToJson(UserRegisterResponseModel data) => json.encode(data.toJson());

class UserRegisterResponseModel {
  UserRegisterResponseModel({
    required this.error,
    required this.message,
  });

  bool error;
  String message;

  factory UserRegisterResponseModel.fromJson(Map<String, dynamic> json) => UserRegisterResponseModel(
    error: json["error"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
  };
}
