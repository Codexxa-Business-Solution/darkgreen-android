// To parse this JSON data, do
//
//     final getProductByIdResponseModel = getProductByIdResponseModelFromJson(jsonString);

import 'dart:convert';

GetProductByIdResponseModel getProductByIdResponseModelFromJson(String str) => GetProductByIdResponseModel.fromJson(json.decode(str));

String getProductByIdResponseModelToJson(GetProductByIdResponseModel data) => json.encode(data.toJson());

class GetProductByIdResponseModel {
  GetProductByIdResponseModel({
    required this.error,
    required this.message,
    required this.total,
    required this.data,
  });

  bool error;
  String message;
  int total;
  List<Datum> data;

  factory GetProductByIdResponseModel.fromJson(Map<String, dynamic> json) => GetProductByIdResponseModel(
    error: json["error"],
    message: json["message"],
    total: json["total"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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
    required this.id,
    required this.rowOrder,
    required this.name,
    required this.taxId,
    required this.slug,
    required this.categoryId,
    required this.subcategoryId,
    required this.indicator,
    required this.manufacturer,
    required this.madeIn,
    required this.returnStatus,
    required this.cancelableStatus,
    required this.tillStatus,
    required this.image,
    required this.otherImages,
    required this.sizeChart,
    required this.description,
    required this.shippingDelivery,
    required this.status,
    required this.ratings,
    required this.numberOfRatings,
    required this.isCodAllowed,
    required this.totalAllowedQuantity,
    required this.dateAdded,
    required this.categoryName,
    required this.subcategoryName,
    required this.taxTitle,
    required this.taxPercentage,
    required this.isAddedToCart,
    required this.isFavorite,
    required this.variants,
  });

  String id;
  String rowOrder;
  String name;
  String taxId;
  String slug;
  String categoryId;
  String subcategoryId;
  String indicator;
  String manufacturer;
  String madeIn;
  String returnStatus;
  String cancelableStatus;
  String tillStatus;
  String image;
  List<dynamic> otherImages;
  String sizeChart;
  String description;
  String shippingDelivery;
  String status;
  String ratings;
  String numberOfRatings;
  String isCodAllowed;
  String totalAllowedQuantity;
  DateTime dateAdded;
  String categoryName;
  String subcategoryName;
  String taxTitle;
  String taxPercentage;
  bool isAddedToCart;
  bool isFavorite;
  List<Variant> variants;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    rowOrder: json["row_order"],
    name: json["name"],
    taxId: json["tax_id"],
    slug: json["slug"],
    categoryId: json["category_id"],
    subcategoryId: json["subcategory_id"],
    indicator: json["indicator"],
    manufacturer: json["manufacturer"],
    madeIn: json["made_in"],
    returnStatus: json["return_status"],
    cancelableStatus: json["cancelable_status"],
    tillStatus: json["till_status"],
    image: json["image"],
    otherImages: List<dynamic>.from(json["other_images"].map((x) => x)),
    sizeChart: json["size_chart"],
    description: json["description"],
    shippingDelivery: json["shipping_delivery"],
    status: json["status"],
    ratings: json["ratings"],
    numberOfRatings: json["number_of_ratings"],
    isCodAllowed: json["is_cod_allowed"],
    totalAllowedQuantity: json["total_allowed_quantity"],
    dateAdded: DateTime.parse(json["date_added"]),
    categoryName: json["category_name"],
    subcategoryName: json["subcategory_name"],
    taxTitle: json["tax_title"],
    taxPercentage: json["tax_percentage"],
    isAddedToCart: json["is_added_to_cart"],
    isFavorite: json["is_favorite"],
    variants: List<Variant>.from(json["variants"].map((x) => Variant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "row_order": rowOrder,
    "name": name,
    "tax_id": taxId,
    "slug": slug,
    "category_id": categoryId,
    "subcategory_id": subcategoryId,
    "indicator": indicator,
    "manufacturer": manufacturer,
    "made_in": madeIn,
    "return_status": returnStatus,
    "cancelable_status": cancelableStatus,
    "till_status": tillStatus,
    "image": image,
    "other_images": List<dynamic>.from(otherImages.map((x) => x)),
    "size_chart": sizeChart,
    "description": description,
    "shipping_delivery": shippingDelivery,
    "status": status,
    "ratings": ratings,
    "number_of_ratings": numberOfRatings,
    "is_cod_allowed": isCodAllowed,
    "total_allowed_quantity": totalAllowedQuantity,
    "date_added": dateAdded.toIso8601String(),
    "category_name": categoryName,
    "subcategory_name": subcategoryName,
    "tax_title": taxTitle,
    "tax_percentage": taxPercentage,
    "is_added_to_cart": isAddedToCart,
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
