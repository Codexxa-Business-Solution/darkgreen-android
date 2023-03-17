// To parse this JSON data, do
//
//     final getAllFavProductsResponseModel = getAllFavProductsResponseModelFromJson(jsonString);

import 'dart:convert';

GetAllFavProductsResponseModel getAllFavProductsResponseModelFromJson(String str) => GetAllFavProductsResponseModel.fromJson(json.decode(str));

String getAllFavProductsResponseModelToJson(GetAllFavProductsResponseModel data) => json.encode(data.toJson());

class GetAllFavProductsResponseModel {
  GetAllFavProductsResponseModel({
    required this.error,
    required this.total,
    required this.data,
  });

  bool error;
  String total;
  List<Datum> data;

  factory GetAllFavProductsResponseModel.fromJson(Map<String, dynamic> json) => GetAllFavProductsResponseModel(
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
  Datum({
    required this.favouriteId,
    required this.userId,
    required this.id,
    required this.rowOrder,
    required this.name,
    required this.slug,
    required this.categoryId,
    required this.totalAllowedQuantity,
    required this.isCodAllowed,
    required this.taxId,
    required this.categoryName,
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
    required this.dateAdded,
    required this.ratings,
    required this.numberOfRatings,
    required this.review,
    required this.rate,
    required this.isFavorite,
    required this.taxTitle,
    required this.taxPercentage,
    required this.variants,
  });

  String favouriteId;
  String userId;
  String id;
  String rowOrder;
  String name;
  String slug;
  String categoryId;
  String totalAllowedQuantity;
  String isCodAllowed;
  String taxId;
  String categoryName;
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
  DateTime dateAdded;
  String ratings;
  String numberOfRatings;
  String review;
  String rate;
  bool isFavorite;
  String taxTitle;
  String taxPercentage;
  List<Variant> variants;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    favouriteId: json["favourite_id"],
    userId: json["user_id"],
    id: json["id"],
    rowOrder: json["row_order"],
    name: json["name"],
    slug: json["slug"],
    categoryId: json["category_id"],
    totalAllowedQuantity: json["total_allowed_quantity"],
    isCodAllowed: json["is_cod_allowed"],
    taxId: json["tax_id"],
    categoryName: json["category_name"],
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
    dateAdded: DateTime.parse(json["date_added"]),
    ratings: json["ratings"],
    numberOfRatings: json["number_of_ratings"],
    review: json["review"],
    rate: json["rate"],
    isFavorite: json["is_favorite"],
    taxTitle: json["tax_title"],
    taxPercentage: json["tax_percentage"],
    variants: List<Variant>.from(json["variants"].map((x) => Variant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "favourite_id": favouriteId,
    "user_id": userId,
    "id": id,
    "row_order": rowOrder,
    "name": name,
    "slug": slug,
    "category_id": categoryId,
    "total_allowed_quantity": totalAllowedQuantity,
    "is_cod_allowed": isCodAllowed,
    "tax_id": taxId,
    "category_name": categoryName,
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
    "date_added": dateAdded.toIso8601String(),
    "ratings": ratings,
    "number_of_ratings": numberOfRatings,
    "review": review,
    "rate": rate,
    "is_favorite": isFavorite,
    "tax_title": taxTitle,
    "tax_percentage": taxPercentage,
    "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
  };
}

class Variant {
  Variant({
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
    required this.sku,
    required this.measurementUnitName,
    required this.stockUnitName,
    required this.cartCount,
    required this.isFlashSales,
    required this.flashSales,
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
  String sku;
  String measurementUnitName;
  String stockUnitName;
  String cartCount;
  String isFlashSales;
  List<FlashSale> flashSales;

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
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
    measurementUnitName: json["measurement_unit_name"],
    stockUnitName: json["stock_unit_name"],
    cartCount: json["cart_count"],
    isFlashSales: json["is_flash_sales"],
    flashSales: List<FlashSale>.from(json["flash_sales"].map((x) => FlashSale.fromJson(x))),
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
    "measurement_unit_name": measurementUnitName,
    "stock_unit_name": stockUnitName,
    "cart_count": cartCount,
    "is_flash_sales": isFlashSales,
    "flash_sales": List<dynamic>.from(flashSales.map((x) => x.toJson())),
  };
}

class FlashSale {
  FlashSale({
    required this.id,
    required this.flashSalesId,
    required this.productId,
    required this.productVariantId,
    required this.price,
    required this.discountedPrice,
    required this.startDate,
    required this.endDate,
    required this.dateCreated,
    required this.status,
    required this.flashSalesName,
  });

  String id;
  String flashSalesId;
  String productId;
  String productVariantId;
  String price;
  String discountedPrice;
  String startDate;
  String endDate;
  String dateCreated;
  String status;
  String flashSalesName;

  factory FlashSale.fromJson(Map<String, dynamic> json) => FlashSale(
    id: json["id"],
    flashSalesId: json["flash_sales_id"],
    productId: json["product_id"],
    productVariantId: json["product_variant_id"],
    price: json["price"],
    discountedPrice: json["discounted_price"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    dateCreated: json["date_created"],
    status: json["status"],
    flashSalesName: json["flash_sales_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "flash_sales_id": flashSalesId,
    "product_id": productId,
    "product_variant_id": productVariantId,
    "price": price,
    "discounted_price": discountedPrice,
    "start_date": startDate,
    "end_date": endDate,
    "date_created": dateCreated,
    "status": status,
    "flash_sales_name": flashSalesName,
  };
}
