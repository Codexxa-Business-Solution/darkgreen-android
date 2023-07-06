// To parse this JSON data, do
//
//     final getPrivacyResponseModel = getPrivacyResponseModelFromJson(jsonString);

import 'dart:convert';

GetPrivacyResponseModel getPrivacyResponseModelFromJson(String str) =>
    GetPrivacyResponseModel.fromJson(json.decode(str));

String getPrivacyResponseModelToJson(GetPrivacyResponseModel data) =>
    json.encode(data.toJson());

class GetPrivacyResponseModel {
  String error;
  String privacy;

  GetPrivacyResponseModel({
    required this.error,
    required this.privacy,
  });

  factory GetPrivacyResponseModel.fromJson(Map<String, dynamic> json) =>
      GetPrivacyResponseModel(
        error: json["error"],
        privacy: json["privacy"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "privacy": privacy,
      };
}
