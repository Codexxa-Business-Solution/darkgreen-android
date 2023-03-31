// To parse this JSON data, do
//
//     final deleteSaveForLaterResponseModel = deleteSaveForLaterResponseModelFromJson(jsonString);

import 'dart:convert';

DeleteSaveForLaterResponseModel deleteSaveForLaterResponseModelFromJson(String str) => DeleteSaveForLaterResponseModel.fromJson(json.decode(str));

String deleteSaveForLaterResponseModelToJson(DeleteSaveForLaterResponseModel data) => json.encode(data.toJson());

class DeleteSaveForLaterResponseModel {
  DeleteSaveForLaterResponseModel({
    required this.error,
    required this.message,
    required this.data,
  });

  bool error;
  String message;
  List<Datum> data;

  factory DeleteSaveForLaterResponseModel.fromJson(Map<String, dynamic> json) => DeleteSaveForLaterResponseModel(
    error: json["error"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.userId,
    required this.productId,
    required this.productVariantId,
    required this.qty,
    required this.saveForLater,
    required this.dateCreated,
    required this.item,
  });

  String id;
  String userId;
  String productId;
  String productVariantId;
  String qty;
  String saveForLater;
  DateTime dateCreated;
  List<Item> item;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    productId: json["product_id"],
    productVariantId: json["product_variant_id"],
    qty: json["qty"],
    saveForLater: json["save_for_later"],
    dateCreated: DateTime.parse(json["date_created"]),
    item: List<Item>.from(json["item"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "product_variant_id": productVariantId,
    "qty": qty,
    "save_for_later": saveForLater,
    "date_created": dateCreated.toIso8601String(),
    "item": List<dynamic>.from(item.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    required this.id,
    required this.productId,
    required this.type,
    required this.measurement,
    required this.measurementUnitId,
    required this.price,
    required this.discountedPrice,
    required this.serveFor,
    required this.stock,
    required this.stockUnitId,
    required this.images,
    this.sku,
    required this.shippingDelivery,
    required this.name,
    required this.isCodAllowed,
    required this.slug,
    required this.image,
    required this.otherImages,
    required this.sizeChart,
    required this.ratings,
    required this.numberOfRatings,
    required this.totalAllowedQuantity,
    required this.review,
    required this.taxPercentage,
    required this.taxTitle,
    required this.stockUnitName,
    required this.unit,
    required this.isAvailable,
  });

  String id;
  String productId;
  String type;
  String measurement;
  String measurementUnitId;
  String price;
  String discountedPrice;
  String serveFor;
  String stock;
  String stockUnitId;
  List<dynamic> images;
  dynamic sku;
  String shippingDelivery;
  String name;
  String isCodAllowed;
  String slug;
  String image;
  List<dynamic> otherImages;
  String sizeChart;
  String ratings;
  String numberOfRatings;
  String totalAllowedQuantity;
  String review;
  String taxPercentage;
  String taxTitle;
  String stockUnitName;
  String unit;
  bool isAvailable;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    productId: json["product_id"],
    type: json["type"],
    measurement: json["measurement"],
    measurementUnitId: json["measurement_unit_id"],
    price: json["price"],
    discountedPrice: json["discounted_price"],
    serveFor: json["serve_for"],
    stock: json["stock"],
    stockUnitId: json["stock_unit_id"],
    images: List<dynamic>.from(json["images"].map((x) => x)),
    sku: json["sku"],
    shippingDelivery: json["shipping_delivery"],
    name: json["name"],
    isCodAllowed: json["is_cod_allowed"],
    slug: json["slug"],
    image: json["image"],
    otherImages: List<dynamic>.from(json["other_images"].map((x) => x)),
    sizeChart: json["size_chart"],
    ratings: json["ratings"],
    numberOfRatings: json["number_of_ratings"],
    totalAllowedQuantity: json["total_allowed_quantity"],
    review: json["review"],
    taxPercentage: json["tax_percentage"],
    taxTitle: json["tax_title"],
    stockUnitName: json["stock_unit_name"],
    unit: json["unit"],
    isAvailable: json["isAvailable"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "type": type,
    "measurement": measurement,
    "measurement_unit_id": measurementUnitId,
    "price": price,
    "discounted_price": discountedPrice,
    "serve_for": serveFor,
    "stock": stock,
    "stock_unit_id": stockUnitId,
    "images": List<dynamic>.from(images.map((x) => x)),
    "sku": sku,
    "shipping_delivery": shippingDelivery,
    "name": name,
    "is_cod_allowed": isCodAllowed,
    "slug": slug,
    "image": image,
    "other_images": List<dynamic>.from(otherImages.map((x) => x)),
    "size_chart": sizeChart,
    "ratings": ratings,
    "number_of_ratings": numberOfRatings,
    "total_allowed_quantity": totalAllowedQuantity,
    "review": review,
    "tax_percentage": taxPercentage,
    "tax_title": taxTitle,
    "stock_unit_name": stockUnitName,
    "unit": unit,
    "isAvailable": isAvailable,
  };
}
