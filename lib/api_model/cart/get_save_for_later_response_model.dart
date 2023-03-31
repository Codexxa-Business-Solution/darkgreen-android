// To parse this JSON data, do
//
//     final getSaveForLaterResponseModel = getSaveForLaterResponseModelFromJson(jsonString);

import 'dart:convert';

GetSaveForLaterResponseModel getSaveForLaterResponseModelFromJson(String str) => GetSaveForLaterResponseModel.fromJson(json.decode(str));

String getSaveForLaterResponseModelToJson(GetSaveForLaterResponseModel data) => json.encode(data.toJson());

class GetSaveForLaterResponseModel {
  GetSaveForLaterResponseModel({
    required this.error,
    required this.message,
    required this.total,
    required this.data,
  });

  bool error;
  String message;
  int total;
  List<Datum> data;

  factory GetSaveForLaterResponseModel.fromJson(Map<String, dynamic> json) => GetSaveForLaterResponseModel(
    error: json["error"],
    message: json["message"],
    total: json["total"] ?? 0,
    data: List<Datum>.from(json["data"] != null ? json["data"].map((x) => Datum.fromJson(x)) :[]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "total": total,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.productId,
    required this.productVariantId,
    required this.isCodAllowed,
    required this.type,
    required this.measurement,
    required this.price,
    required this.discountedPrice,
    required this.serveFor,
    required this.stock,
    required this.name,
    required this.slug,
    required this.image,
    required this.taxPercentage,
    required this.taxTitle,
    required this.totalAllowedQuantity,
    required this.images,
    required this.unit,
    required this.stockUnitName,
    required this.id,
    required this.qty,
    required this.userId,
    required this.saveForLater,
  });

  String productId;
  String productVariantId;
  String isCodAllowed;
  String type;
  String measurement;
  String price;
  String discountedPrice;
  String serveFor;
  String stock;
  String name;
  String slug;
  String image;
  String taxPercentage;
  String taxTitle;
  String totalAllowedQuantity;
  List<dynamic> images;
  String unit;
  String stockUnitName;
  String id;
  String qty;
  String userId;
  String saveForLater;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    productId: json["product_id"],
    productVariantId: json["product_variant_id"],
    isCodAllowed: json["is_cod_allowed"],
    type: json["type"],
    measurement: json["measurement"],
    price: json["price"],
    discountedPrice: json["discounted_price"],
    serveFor: json["serve_for"],
    stock: json["stock"],
    name: json["name"],
    slug: json["slug"],
    image: json["image"],
    taxPercentage: json["tax_percentage"],
    taxTitle: json["tax_title"],
    totalAllowedQuantity: json["total_allowed_quantity"],
    images: List<dynamic>.from(json["images"].map((x) => x)),
    unit: json["unit"],
    stockUnitName: json["stock_unit_name"],
    id: json["id"],
    qty: json["qty"],
    userId: json["user_id"],
    saveForLater: json["save_for_later"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_variant_id": productVariantId,
    "is_cod_allowed": isCodAllowed,
    "type": type,
    "measurement": measurement,
    "price": price,
    "discounted_price": discountedPrice,
    "serve_for": serveFor,
    "stock": stock,
    "name": name,
    "slug": slug,
    "image": image,
    "tax_percentage": taxPercentage,
    "tax_title": taxTitle,
    "total_allowed_quantity": totalAllowedQuantity,
    "images": List<dynamic>.from(images.map((x) => x)),
    "unit": unit,
    "stock_unit_name": stockUnitName,
    "id": id,
    "qty": qty,
    "user_id": userId,
    "save_for_later": saveForLater,
  };
}
