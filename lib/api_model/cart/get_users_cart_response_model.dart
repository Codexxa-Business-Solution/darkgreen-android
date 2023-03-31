// To parse this JSON data, do
//
//     final getUserCartResponseModel = getUserCartResponseModelFromJson(jsonString);

import 'dart:convert';

GetUserCartResponseModel getUserCartResponseModelFromJson(String str) => GetUserCartResponseModel.fromJson(json.decode(str));

String getUserCartResponseModelToJson(GetUserCartResponseModel data) => json.encode(data.toJson());

class GetUserCartResponseModel {
  GetUserCartResponseModel({
    required this.error,
    required this.total,
    required this.message,
    required this.data,
    required this.saveForLater,
  });

  bool error;
  int total;
  String message;
  List<Datum> data;
  List<dynamic> saveForLater;

  factory GetUserCartResponseModel.fromJson(Map<String, dynamic> json) => GetUserCartResponseModel(
    error: json["error"],
    total: json["total"] ?? 0,
    message: json["message"],
    data: List<Datum>.from(json["data"] != null ? json["data"].map((x) => Datum.fromJson(x)) : []),
    saveForLater: List<dynamic>.from(json["save_for_later"] != null ? json["save_for_later"].map((x) => x) : []),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "total": total,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "save_for_later": List<dynamic>.from(saveForLater.map((x) => x)),
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
