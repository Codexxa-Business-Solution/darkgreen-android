// To parse this JSON data, do
//
//     final getOrderDeleteResponseModel = getOrderDeleteResponseModelFromJson(jsonString);

import 'dart:convert';

GetOrderDeleteResponseModel getOrderDeleteResponseModelFromJson(String str) =>
    GetOrderDeleteResponseModel.fromJson(json.decode(str));

String getOrderDeleteResponseModelToJson(GetOrderDeleteResponseModel data) =>
    json.encode(data.toJson());

class GetOrderDeleteResponseModel {
  bool error;
  String message;

  GetOrderDeleteResponseModel({
    required this.error,
    required this.message,
  });

  factory GetOrderDeleteResponseModel.fromJson(Map<String, dynamic> json) =>
      GetOrderDeleteResponseModel(
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
      };
}
