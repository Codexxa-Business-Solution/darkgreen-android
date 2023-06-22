// To parse this JSON data, do
//
//     final getOrderPlacedResponceModel = getOrderPlacedResponceModelFromJson(jsonString);

import 'dart:convert';

GetOrderPlacedResponceModel getOrderPlacedResponceModelFromJson(String str) =>
    GetOrderPlacedResponceModel.fromJson(json.decode(str));

String getOrderPlacedResponceModelToJson(GetOrderPlacedResponceModel data) =>
    json.encode(data.toJson());

class GetOrderPlacedResponceModel {
  bool error;
  String message;
  String orderId;

  GetOrderPlacedResponceModel({
    required this.error,
    required this.message,
    required this.orderId,
  });

  factory GetOrderPlacedResponceModel.fromJson(Map<String, dynamic> json) =>
      GetOrderPlacedResponceModel(
        error: json["error"],
        message: json["message"],
        orderId: json["order_id"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "order_id": orderId,
      };
}
