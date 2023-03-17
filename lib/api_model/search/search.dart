// To parse this JSON data, do
//
//     final getSearchProductResponseModel = getSearchProductResponseModelFromJson(jsonString);

import 'dart:convert';

GetSearchProductResponseModel getSearchProductResponseModelFromJson(String str) => GetSearchProductResponseModel.fromJson(json.decode(str));

String getSearchProductResponseModelToJson(GetSearchProductResponseModel data) => json.encode(data.toJson());

class GetSearchProductResponseModel {
  GetSearchProductResponseModel({
    required this.error,
    required this.message,
    required this.total,
    required this.limit,
    required this.offset,
    required this.data,
  });

  bool error;
  String message;
  String total;
  String limit;
  int offset;
  List<Datum> data;

  factory GetSearchProductResponseModel.fromJson(Map<String, dynamic> json) => GetSearchProductResponseModel(
    error: json["error"],
    message: json["message"],
    total: json["total"],
    limit: json["limit"],
    offset: json["offset"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "total": total,
    "limit": limit,
    "offset": offset,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.indicator,
    required this.image,
    required this.ratings,
    required this.numberOfRatings,
    required this.totalAllowedQuantity,
    required this.slug,
    required this.description,
    required this.status,
    required this.categoryName,
    required this.taxPercentage,
    required this.price,
    required this.isFavorite,
    required this.variants,
  });

  String id;
  String name;
  String indicator;
  String image;
  String ratings;
  String numberOfRatings;
  String totalAllowedQuantity;
  String slug;
  String description;
  String status;
  String categoryName;
  String taxPercentage;
  String price;
  bool isFavorite;
  List<Variant> variants;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    indicator: json["indicator"],
    image: json["image"],
    ratings: json["ratings"],
    numberOfRatings: json["number_of_ratings"],
    totalAllowedQuantity: json["total_allowed_quantity"],
    slug: json["slug"],
    description: json["description"],
    status: json["status"],
    categoryName: json["category_name"],
    taxPercentage: json["tax_percentage"],
    price: json["price"],
    isFavorite: json["is_favorite"],
    variants: List<Variant>.from(json["variants"].map((x) => Variant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "indicator": indicator,
    "image": image,
    "ratings": ratings,
    "number_of_ratings": numberOfRatings,
    "total_allowed_quantity": totalAllowedQuantity,
    "slug": slug,
    "description": description,
    "status": status,
    "category_name": categoryName,
    "tax_percentage": taxPercentage,
    "price": price,
    "is_favorite": isFavorite,
    "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
  };
}

class Variant {
  Variant({
    required this.type,
    required this.id,
    required this.productId,
    required this.price,
    required this.discountedPrice,
    required this.serveFor,
    required this.stock,
    required this.measurement,
    required this.measurementUnitName,
    required this.stockUnitName,
    required this.images,
    required this.cartCount,
    required this.isFlashSales,
    required this.flashSales,
  });

  String type;
  String id;
  String productId;
  String price;
  String discountedPrice;
  String serveFor;
  String stock;
  String measurement;
  String measurementUnitName;
  String stockUnitName;
  List<dynamic> images;
  String cartCount;
  bool isFlashSales;
  List<FlashSale> flashSales;

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    type: json["type"],
    id: json["id"],
    productId: json["product_id"],
    price: json["price"],
    discountedPrice: json["discounted_price"],
    serveFor: json["serve_for"],
    stock: json["stock"],
    measurement: json["measurement"],
    measurementUnitName: json["measurement_unit_name"],
    stockUnitName: json["stock_unit_name"],
    images: List<dynamic>.from(json["images"].map((x) => x)),
    cartCount: json["cart_count"],
    isFlashSales: json["is_flash_sales"],
    flashSales: List<FlashSale>.from(json["flash_sales"].map((x) => FlashSale.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id,
    "product_id": productId,
    "price": price,
    "discounted_price": discountedPrice,
    "serve_for": serveFor,
    "stock": stock,
    "measurement": measurement,
    "measurement_unit_name": measurementUnitName,
    "stock_unit_name": stockUnitName,
    "images": List<dynamic>.from(images.map((x) => x)),
    "cart_count": cartCount,
    "is_flash_sales": isFlashSales,
    "flash_sales": List<dynamic>.from(flashSales.map((x) => x.toJson())),
  };
}

class FlashSale {
  FlashSale({
    required this.price,
    required this.discountedPrice,
    required this.startDate,
    required this.endDate,
    required this.isStart,
  });

  String price;
  String discountedPrice;
  String startDate;
  String endDate;
  bool isStart;

  factory FlashSale.fromJson(Map<String, dynamic> json) => FlashSale(
    price: json["price"],
    discountedPrice: json["discounted_price"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    isStart: json["is_start"],
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "discounted_price": discountedPrice,
    "start_date": startDate,
    "end_date": endDate,
    "is_start": isStart,
  };
}
