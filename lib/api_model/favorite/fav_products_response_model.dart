class FavouriteResponse {
  bool error;
  String? total;
  String? message;
  List<List<Data>>? data;

  FavouriteResponse({required this.error, this.total, this.data});

  factory FavouriteResponse.fromJson(Map<String, dynamic> json) {
    return FavouriteResponse(
      error: json['error'] as bool,
      total: json['total'] as String,
      data: (json['data'] as List)
          .map((item) =>
              (item as List).map((data) => Data.fromJson(data)).toList())
          .toList(),
    );
  }
}

class Data {
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
  String dateAdded;
  String ratings;
  String numberOfRatings;
  String review;
  String rate;
  bool isFavorite;
  String taxTitle;
  String taxPercentage;
  List<Variant> variants;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      favouriteId: json['favourite_id'] as String,
      userId: json['user_id'] as String,
      id: json['id'] as String,
      rowOrder: json['row_order'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      categoryId: json['category_id'] as String,
      totalAllowedQuantity: json['total_allowed_quantity'] as String,
      isCodAllowed: json['is_cod_allowed'] as String,
      taxId: json['tax_id'] as String,
      categoryName: json['category_name'] as String,
      subcategoryId: json['subcategory_id'] as String,
      indicator: json['indicator'] as String,
      manufacturer: json['manufacturer'] as String,
      madeIn: json['made_in'] as String,
      returnStatus: json['return_status'] as String,
      cancelableStatus: json['cancelable_status'] as String,
      tillStatus: json['till_status'] as String,
      image: json['image'] as String,
      otherImages: json['other_images'] as List<dynamic>,
      sizeChart: json['size_chart'] as String,
      description: json['description'] as String,
      shippingDelivery: json['shipping_delivery'] as String,
      status: json['status'] as String,
      dateAdded: json['date_added'] as String,
      ratings: json['ratings'] as String,
      numberOfRatings: json['number_of_ratings'] as String,
      review: json['review'] as String,
      rate: json['rate'] as String,
      isFavorite: json['is_favorite'] as bool,
      taxTitle: json['tax_title'] as String,
      taxPercentage: json['tax_percentage'] as String,
      variants: (json['variants'] as List)
          .map((variant) => Variant.fromJson(variant))
          .toList(),
    );
  }
}

class Variant {
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
  dynamic hsnCode;
  String measurementUnitName;
  String stockUnitName;
  String cartCount;
  String isFlashSales;
  List<FlashSale> flashSales;

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
    required this.hsnCode,
    required this.measurementUnitName,
    required this.stockUnitName,
    required this.cartCount,
    required this.isFlashSales,
    required this.flashSales,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json['id'] as String,
      productId: json['product_id'] as String,
      type: json['type'] as String,
      measurement: json['measurement'] as String,
      measurementUnitId: json['measurement_unit_id'] as String,
      price: json['price'] as String,
      discountedPrice: json['discounted_price'] as String,
      serveFor: json['serve_for'] as String,
      stock: json['stock'] as String,
      stockUnitId: json['stock_unit_id'] as String,
      images: json['images'] as List<dynamic>,
      sku: json['sku'] as String,
      hsnCode: json['hsn_code'],
      measurementUnitName: json['measurement_unit_name'] as String,
      stockUnitName: json['stock_unit_name'] as String,
      cartCount: json['cart_count'] as String,
      isFlashSales: json['is_flash_sales'] as String,
      flashSales: (json['flash_sales'] as List)
          .map((flashSale) => FlashSale.fromJson(flashSale))
          .toList(),
    );
  }
}

class FlashSale {
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

  factory FlashSale.fromJson(Map<String, dynamic> json) {
    return FlashSale(
      id: json['id'] as String,
      flashSalesId: json['flash_sales_id'] as String,
      productId: json['product_id'] as String,
      productVariantId: json['product_variant_id'] as String,
      price: json['price'] as String,
      discountedPrice: json['discounted_price'] as String,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      dateCreated: json['date_created'] as String,
      status: json['status'] as String,
      flashSalesName: json['flash_sales_name'] as String,
    );
  }
}
