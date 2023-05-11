// To parse this JSON data, do
//
//     final getPromoCodeResponseModel = getPromoCodeResponseModelFromJson(jsonString);

import 'dart:convert';

GetPromoCodeResponseModel getPromoCodeResponseModelFromJson(String str) => GetPromoCodeResponseModel.fromJson(json.decode(str));

String getPromoCodeResponseModelToJson(GetPromoCodeResponseModel data) => json.encode(data.toJson());

class GetPromoCodeResponseModel {
  bool error;
  String total;
  List<Datum> data;

  GetPromoCodeResponseModel({
    required this.error,
    required this.total,
    required this.data,
  });

  factory GetPromoCodeResponseModel.fromJson(Map<String, dynamic> json) => GetPromoCodeResponseModel(
    error: json["error"],
    total: json["total"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "total": total,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String promoCode;
  String message;
  DateTime startDate;
  DateTime endDate;
  String noOfUsers;
  String minimumOrderAmount;
  String discount;
  String discountType;
  String maxDiscountAmount;
  String repeatUsage;
  String noOfRepeatUsage;
  String status;
  DateTime dateCreated;
  List<IsValidate> isValidate;

  Datum({
    required this.id,
    required this.promoCode,
    required this.message,
    required this.startDate,
    required this.endDate,
    required this.noOfUsers,
    required this.minimumOrderAmount,
    required this.discount,
    required this.discountType,
    required this.maxDiscountAmount,
    required this.repeatUsage,
    required this.noOfRepeatUsage,
    required this.status,
    required this.dateCreated,
    required this.isValidate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    promoCode: json["promo_code"],
    message: json["message"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    noOfUsers: json["no_of_users"],
    minimumOrderAmount: json["minimum_order_amount"],
    discount: json["discount"],
    discountType: json["discount_type"],
    maxDiscountAmount: json["max_discount_amount"],
    repeatUsage: json["repeat_usage"],
    noOfRepeatUsage: json["no_of_repeat_usage"],
    status: json["status"],
    dateCreated: DateTime.parse(json["date_created"]),
    isValidate: List<IsValidate>.from(json["is_validate"].map((x) => IsValidate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "promo_code": promoCode,
    "message": message,
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "no_of_users": noOfUsers,
    "minimum_order_amount": minimumOrderAmount,
    "discount": discount,
    "discount_type": discountType,
    "max_discount_amount": maxDiscountAmount,
    "repeat_usage": repeatUsage,
    "no_of_repeat_usage": noOfRepeatUsage,
    "status": status,
    "date_created": dateCreated.toIso8601String(),
    "is_validate": List<dynamic>.from(isValidate.map((x) => x.toJson())),
  };
}

class IsValidate {
  bool error;
  String message;
  String promoCode;
  String promoCodeMessage;
  int total;
  int discount;
  int discountedAmount;

  IsValidate({
    required this.error,
    required this.message,
    required this.promoCode,
    required this.promoCodeMessage,
    required this.total,
    required this.discount,
    required this.discountedAmount,
  });

  factory IsValidate.fromJson(Map<String, dynamic> json) => IsValidate(
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
