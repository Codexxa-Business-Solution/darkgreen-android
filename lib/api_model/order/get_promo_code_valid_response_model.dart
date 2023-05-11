// To parse this JSON data, do
//
//     final getPromoCodeValidResponseModel = getPromoCodeValidResponseModelFromJson(jsonString);

import 'dart:convert';

GetPromoCodeValidResponseModel getPromoCodeValidResponseModelFromJson(String str) => GetPromoCodeValidResponseModel.fromJson(json.decode(str));

String getPromoCodeValidResponseModelToJson(GetPromoCodeValidResponseModel data) => json.encode(data.toJson());

class GetPromoCodeValidResponseModel {
  bool error;
  String message;
  String promoCode;
  String promoCodeMessage;
  String total;
  String discount;
  String discountedAmount;

  GetPromoCodeValidResponseModel({
    required this.error,
    required this.message,
    required this.promoCode,
    required this.promoCodeMessage,
    required this.total,
    required this.discount,
    required this.discountedAmount,
  });

  factory GetPromoCodeValidResponseModel.fromJson(Map<String, dynamic> json) => GetPromoCodeValidResponseModel(
    error: json["error"],
    message: json["message"],
    promoCode: json["promo_code"],
    promoCodeMessage: json["promo_code_message"],
    total: json["total"],
    discount: json["discount"],
    discountedAmount: json["discounted_amount"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "promo_code": promoCode,
    "promo_code_message": promoCodeMessage,
    "total": total,
    "discount": discount,
    "discounted_amount": discountedAmount,
  };
}
