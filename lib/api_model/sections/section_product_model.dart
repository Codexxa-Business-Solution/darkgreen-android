class SectionResponse {
  bool? error;
  String? message;
  String? total;
  List<Data>? data;

  SectionResponse({this.error, this.message, this.total, this.data});

  SectionResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    total = json['total'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    data['total'] = total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? rowOrder;
  String? name;
  String? taxId;
  String? slug;
  String? fssaiLicNo;
  String? categoryId;
  String? subcategoryId;
  String? indicator;
  String? manufacturer;
  String? madeIn;
  String? returnStatus;
  String? cancelableStatus;
  String? tillStatus;
  String? image;
  List<String>? otherImages;
  String? sizeChart;
  String? description;
  String? shippingDelivery;
  String? status;
  String? ratings;
  String? numberOfRatings;
  String? isCodAllowed;
  String? totalAllowedQuantity;
  String? dateAdded;
  String? productId;
  String? review;
  String? rate;
  String? categoryName;
  String? taxTitle;
  String? taxPercentage;
  bool? isFavorite;
  List<Variants>? variants;

  Data(
      {this.id,
      this.rowOrder,
      this.name,
      this.taxId,
      this.slug,
      this.fssaiLicNo,
      this.categoryId,
      this.subcategoryId,
      this.indicator,
      this.manufacturer,
      this.madeIn,
      this.returnStatus,
      this.cancelableStatus,
      this.tillStatus,
      this.image,
      this.otherImages,
      this.sizeChart,
      this.description,
      this.shippingDelivery,
      this.status,
      this.ratings,
      this.numberOfRatings,
      this.isCodAllowed,
      this.totalAllowedQuantity,
      this.dateAdded,
      this.productId,
      this.review,
      this.rate,
      this.categoryName,
      this.taxTitle,
      this.taxPercentage,
      this.isFavorite,
      this.variants});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rowOrder = json['row_order'];
    name = json['name'];
    taxId = json['tax_id'];
    slug = json['slug'];
    fssaiLicNo = json['fssai_lic_no'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    indicator = json['indicator'];
    manufacturer = json['manufacturer'];
    madeIn = json['made_in'];
    returnStatus = json['return_status'];
    cancelableStatus = json['cancelable_status'];
    tillStatus = json['till_status'];
    image = json['image'];
    otherImages = json['other_images'].cast<String>();
    sizeChart = json['size_chart'];
    description = json['description'];
    shippingDelivery = json['shipping_delivery'];
    status = json['status'];
    ratings = json['ratings'];
    numberOfRatings = json['number_of_ratings'];
    isCodAllowed = json['is_cod_allowed'];
    totalAllowedQuantity = json['total_allowed_quantity'];
    dateAdded = json['date_added'];
    productId = json['product_id'];
    review = json['review'];
    rate = json['rate'];
    categoryName = json['category_name'];
    taxTitle = json['tax_title'];
    taxPercentage = json['tax_percentage'];
    isFavorite = json['is_favorite'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['row_order'] = this.rowOrder;
    data['name'] = this.name;
    data['tax_id'] = this.taxId;
    data['slug'] = this.slug;
    data['fssai_lic_no'] = this.fssaiLicNo;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['indicator'] = this.indicator;
    data['manufacturer'] = this.manufacturer;
    data['made_in'] = this.madeIn;
    data['return_status'] = this.returnStatus;
    data['cancelable_status'] = this.cancelableStatus;
    data['till_status'] = this.tillStatus;
    data['image'] = this.image;
    data['other_images'] = this.otherImages;
    data['size_chart'] = this.sizeChart;
    data['description'] = this.description;
    data['shipping_delivery'] = this.shippingDelivery;
    data['status'] = this.status;
    data['ratings'] = this.ratings;
    data['number_of_ratings'] = this.numberOfRatings;
    data['is_cod_allowed'] = this.isCodAllowed;
    data['total_allowed_quantity'] = this.totalAllowedQuantity;
    data['date_added'] = this.dateAdded;
    data['product_id'] = this.productId;
    data['review'] = this.review;
    data['rate'] = this.rate;
    data['category_name'] = this.categoryName;
    data['tax_title'] = this.taxTitle;
    data['tax_percentage'] = this.taxPercentage;
    data['is_favorite'] = this.isFavorite;
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Variants {
  String? id;
  String? productId;
  String? type;
  String? measurement;
  String? measurementUnitId;
  String? price;
  String? discountedPrice;
  String? serveFor;
  String? stock;
  String? stockUnitId;
  List<String>? images;
  String? sku;
  String? hsnCode;
  String? measurementUnitName;
  String? stockUnitName;
  String? cartCount;
  String? isFlashSales;
  List<FlashSales>? flashSales;

  Variants(
      {this.id,
      this.productId,
      this.type,
      this.measurement,
      this.measurementUnitId,
      this.price,
      this.discountedPrice,
      this.serveFor,
      this.stock,
      this.stockUnitId,
      this.images,
      this.sku,
      this.hsnCode,
      this.measurementUnitName,
      this.stockUnitName,
      this.cartCount,
      this.isFlashSales,
      this.flashSales});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    type = json['type'];
    measurement = json['measurement'];
    measurementUnitId = json['measurement_unit_id'];
    price = json['price'];
    discountedPrice = json['discounted_price'];
    serveFor = json['serve_for'];
    stock = json['stock'];
    stockUnitId = json['stock_unit_id'];
    images = json['images'].cast<String>();
    sku = json['sku'];
    hsnCode = json['hsn_code'];
    measurementUnitName = json['measurement_unit_name'];
    stockUnitName = json['stock_unit_name'];
    cartCount = json['cart_count'];
    isFlashSales = json['is_flash_sales'];
    if (json['flash_sales'] != null) {
      flashSales = <FlashSales>[];
      json['flash_sales'].forEach((v) {
        flashSales!.add(FlashSales.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['type'] = this.type;
    data['measurement'] = this.measurement;
    data['measurement_unit_id'] = this.measurementUnitId;
    data['price'] = this.price;
    data['discounted_price'] = this.discountedPrice;
    data['serve_for'] = this.serveFor;
    data['stock'] = this.stock;
    data['stock_unit_id'] = this.stockUnitId;
    data['images'] = this.images;
    data['sku'] = this.sku;
    data['hsn_code'] = this.hsnCode;
    data['measurement_unit_name'] = this.measurementUnitName;
    data['stock_unit_name'] = this.stockUnitName;
    data['cart_count'] = this.cartCount;
    data['is_flash_sales'] = this.isFlashSales;
    if (this.flashSales != null) {
      data['flash_sales'] = this.flashSales!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FlashSales {
  String? id;
  String? flashSalesId;
  String? productId;
  String? productVariantId;
  String? price;
  String? discountedPrice;
  String? startDate;
  String? endDate;
  String? dateCreated;
  String? status;
  String? flashSalesName;

  FlashSales(
      {this.id,
      this.flashSalesId,
      this.productId,
      this.productVariantId,
      this.price,
      this.discountedPrice,
      this.startDate,
      this.endDate,
      this.dateCreated,
      this.status,
      this.flashSalesName});

  FlashSales.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    flashSalesId = json['flash_sales_id'];
    productId = json['product_id'];
    productVariantId = json['product_variant_id'];
    price = json['price'];
    discountedPrice = json['discounted_price'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    dateCreated = json['date_created'];
    status = json['status'];
    flashSalesName = json['flash_sales_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['flash_sales_id'] = this.flashSalesId;
    data['product_id'] = this.productId;
    data['product_variant_id'] = this.productVariantId;
    data['price'] = this.price;
    data['discounted_price'] = this.discountedPrice;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['date_created'] = this.dateCreated;
    data['status'] = this.status;
    data['flash_sales_name'] = this.flashSalesName;
    return data;
  }
}
