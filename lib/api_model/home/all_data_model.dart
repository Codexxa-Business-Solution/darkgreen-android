class AllData {
  bool? error;
  String? message;
  String? style;
  String? visibleCount;
  String? columnCount;
  List<String>? categoryOfferImages;
  List<String>? sliderOfferImages;
  List<String>? flashSalesOfferImages;
  List<Categories>? categories;
  List<SliderImages>? sliderImages;
  List<Sections>? sections;
  List<String>? offerImages;
  List<String>? flashSales;
  List<SocialMedia>? socialMedia;
  Settings? settings;

  AllData(
      {this.error,
      this.message,
      this.style,
      this.visibleCount,
      this.columnCount,
      this.categoryOfferImages,
      this.sliderOfferImages,
      this.flashSalesOfferImages,
      this.categories,
      this.sliderImages,
      this.sections,
      this.offerImages,
      this.flashSales,
      this.socialMedia,
      this.settings});

  AllData.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    style = json['style'];
    visibleCount = json['visible_count'];
    columnCount = json['column_count'];
    if (json['category_offer_images'] != null) {
      categoryOfferImages = [];
      json['category_offer_images'].forEach((v) {
        categoryOfferImages!.add("");
      });
    }
    if (json['slider_offer_images'] != null) {
      sliderOfferImages = [];
      json['slider_offer_images'].forEach((v) {
        sliderOfferImages!.add("");
      });
    }
    if (json['flash_sales_offer_images'] != null) {
      flashSalesOfferImages = [];
      json['flash_sales_offer_images'].forEach((v) {
        flashSalesOfferImages!.add("");
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['slider_images'] != null) {
      sliderImages = <SliderImages>[];
      json['slider_images'].forEach((v) {
        sliderImages!.add(new SliderImages.fromJson(v));
      });
    }
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(new Sections.fromJson(v));
      });
    }
    if (json['offer_images'] != null) {
      offerImages = [];
      json['offer_images'].forEach((v) {
        offerImages!.add("");
      });
    }
    if (json['flash_sales'] != null) {
      flashSales = [];
      json['flash_sales'].forEach((v) {
        flashSales!.add("");
      });
    }
    if (json['social_media'] != null) {
      socialMedia = <SocialMedia>[];
      json['social_media'].forEach((v) {
        socialMedia!.add(new SocialMedia.fromJson(v));
      });
    }
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    data['style'] = this.style;
    data['visible_count'] = this.visibleCount;
    data['column_count'] = this.columnCount;
    if (this.categoryOfferImages != null) {
      data['category_offer_images'] =
          this.categoryOfferImages!.map((v) => v).toList();
    }
    if (this.sliderOfferImages != null) {
      data['slider_offer_images'] =
          this.sliderOfferImages!.map((v) => v).toList();
    }
    if (this.flashSalesOfferImages != null) {
      data['flash_sales_offer_images'] =
          this.flashSalesOfferImages!.map((v) => v).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.sliderImages != null) {
      data['slider_images'] =
          this.sliderImages!.map((v) => v.toJson()).toList();
    }
    if (this.sections != null) {
      data['sections'] = this.sections!.map((v) => v.toJson()).toList();
    }
    if (this.offerImages != null) {
      data['offer_images'] = this.offerImages!.map((v) => v).toList();
    }
    if (this.flashSales != null) {
      data['flash_sales'] = this.flashSales!.map((v) => v).toList();
    }
    if (this.socialMedia != null) {
      data['social_media'] = this.socialMedia!.map((v) => v.toJson()).toList();
    }
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    return data;
  }
}

class Categories {
  String? id;
  String? rowOrder;
  String? name;
  String? subtitle;
  String? image;
  int? status;
  String? webImage;
  Childs? childs;

  Categories(
      {this.id,
      this.rowOrder,
      this.name,
      this.subtitle,
      this.image,
      this.status,
      this.webImage,
      this.childs});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rowOrder = json['row_order'];
    name = json['name'];
    subtitle = json['subtitle'];
    image = json['image'];
    status = json['status'];
    webImage = json['web_image'];
    childs =
        json['childs'] != null ? new Childs.fromJson(json['childs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['row_order'] = this.rowOrder;
    data['name'] = this.name;
    data['subtitle'] = this.subtitle;
    data['image'] = this.image;
    data['status'] = this.status;
    data['web_image'] = this.webImage;
    if (this.childs != null) {
      data['childs'] = this.childs!.toJson();
    }
    return data;
  }
}

class Childs {
  DetergentLiquid1? detergentLiquid1;
  DetergentLiquid1? detergentSoap;
  DetergentLiquid1? chineseFood1;
  DetergentLiquid1? vegetables;
  DetergentLiquid1? fruits;

  Childs(
      {this.detergentLiquid1,
      this.detergentSoap,
      this.chineseFood1,
      this.vegetables,
      this.fruits});

  Childs.fromJson(Map<String, dynamic> json) {
    detergentLiquid1 = json['detergent-liquid-1'] != null
        ? new DetergentLiquid1.fromJson(json['detergent-liquid-1'])
        : null;
    detergentSoap = json['detergent-soap'] != null
        ? new DetergentLiquid1.fromJson(json['detergent-soap'])
        : null;
    chineseFood1 = json['chinese-food-1'] != null
        ? new DetergentLiquid1.fromJson(json['chinese-food-1'])
        : null;
    vegetables = json['vegetables'] != null
        ? new DetergentLiquid1.fromJson(json['vegetables'])
        : null;
    fruits = json['fruits'] != null
        ? new DetergentLiquid1.fromJson(json['fruits'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detergentLiquid1 != null) {
      data['detergent-liquid-1'] = this.detergentLiquid1!.toJson();
    }
    if (this.detergentSoap != null) {
      data['detergent-soap'] = this.detergentSoap!.toJson();
    }
    if (this.chineseFood1 != null) {
      data['chinese-food-1'] = this.chineseFood1!.toJson();
    }
    if (this.vegetables != null) {
      data['vegetables'] = this.vegetables!.toJson();
    }
    if (this.fruits != null) {
      data['fruits'] = this.fruits!.toJson();
    }
    return data;
  }
}

class DetergentLiquid1 {
  String? id;
  String? rowOrder;
  String? categoryId;
  String? name;
  String? slug;
  String? subtitle;
  String? image;

  DetergentLiquid1(
      {this.id,
      this.rowOrder,
      this.categoryId,
      this.name,
      this.slug,
      this.subtitle,
      this.image});

  DetergentLiquid1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rowOrder = json['row_order'];
    categoryId = json['category_id'];
    name = json['name'];
    slug = json['slug'];
    subtitle = json['subtitle'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['row_order'] = this.rowOrder;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['subtitle'] = this.subtitle;
    data['image'] = this.image;
    return data;
  }
}

class SliderImages {
  String? type;
  String? typeId;
  String? name;
  String? slug;
  String? sliderUrl;
  String? title;
  String? shortDescription;
  String? image;
  List? image2;

  SliderImages(
      {this.type,
      this.typeId,
      this.name,
      this.slug,
      this.sliderUrl,
      this.title,
      this.shortDescription,
      this.image,
      this.image2});

  SliderImages.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    typeId = json['type_id'];
    name = json['name'];
    slug = json['slug'];
    sliderUrl = json['slider_url'];
    title = json['title'];
    shortDescription = json['short_description'];
    image = json['image'];
    if (json['image2'] != null) {
      image2 = [];
      json['image2'].forEach((v) {
        image2!.add("");
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['type_id'] = this.typeId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['slider_url'] = this.sliderUrl;
    data['title'] = this.title;
    data['short_description'] = this.shortDescription;
    data['image'] = this.image;
    if (this.image2 != null) {
      data['image2'] = this.image2!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sections {
  String? id;
  String? rowOrder;
  String? title;
  String? shortDescription;
  String? style;
  String? productType;
  String? countOfProducts;
  List? offerImages;
  List<Products>? products;

  Sections(
      {this.id,
      this.rowOrder,
      this.title,
      this.shortDescription,
      this.style,
      this.productType,
      this.countOfProducts,
      this.offerImages,
      this.products});

  Sections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rowOrder = json['row_order'];
    title = json['title'];
    shortDescription = json['short_description'];
    style = json['style'];
    productType = json['product_type'];
    countOfProducts = json['count_of_products'];
    if (json['offer_images'] != null) {
      offerImages = [];
      json['offer_images'].forEach((v) {
        offerImages!.add("");
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['row_order'] = this.rowOrder;
    data['title'] = this.title;
    data['short_description'] = this.shortDescription;
    data['style'] = this.style;
    data['product_type'] = this.productType;
    data['count_of_products'] = this.countOfProducts;
    if (this.offerImages != null) {
      data['offer_images'] = this.offerImages!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
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
  String? categoryName;
  String? review;
  String? rate;
  String? taxTitle;
  String? taxPercentage;
  bool? isFavorite;
  List<Variants>? variants;

  Products(
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
      this.categoryName,
      this.review,
      this.rate,
      this.taxTitle,
      this.taxPercentage,
      this.isFavorite,
      this.variants});

  Products.fromJson(Map<String, dynamic> json) {
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
    categoryName = json['category_name'];
    review = json['review'];
    rate = json['rate'];
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
    data['category_name'] = this.categoryName;
    data['review'] = this.review;
    data['rate'] = this.rate;
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
  List? images;
  String? sku;
  String? hsnCode;
  String? measurementUnitName;
  String? stockUnitName;
  String? cartCount;
  bool? isFlashSales;
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
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images!.add("");
      });
    }
    sku = json['sku'];
    hsnCode = json['hsn_code'];
    measurementUnitName = json['measurement_unit_name'];
    stockUnitName = json['stock_unit_name'];
    cartCount = json['cart_count'];
    isFlashSales = json['is_flash_sales'];
    if (json['flash_sales'] != null) {
      flashSales = <FlashSales>[];
      json['flash_sales'].forEach((v) {
        flashSales!.add(new FlashSales.fromJson(v));
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
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
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

class SocialMedia {
  String? id;
  String? icon;
  String? link;

  SocialMedia({this.id, this.icon, this.link});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['icon'] = this.icon;
    data['link'] = this.link;
    return data;
  }
}

class Settings {
  String? logo;
  String? privacyPolicy;
  String? termsConditions;
  String? fcmServerKey;
  String? contactUs;
  String? systemConfigurations;
  String? systemTimezoneGmt;
  String? systemConfigurationsId;
  String? appName;
  String? supportNumber;
  String? supportEmail;
  String? currentVersion;
  String? minimumVersionRequired;
  String? isVersionSystemOn;
  String? storeAddress;
  String? mapLatitude;
  String? mapLongitude;
  String? currency;
  String? systemTimezone;
  String? maxCartItemsCount;
  String? generateOtp;
  String? areaWiseDeliveryCharge;
  String? minAmount;
  String? minOrderAmount;
  String? deliveryCharge;
  String? isReferEarnOn;
  String? minReferEarnOrderAmount;
  String? referEarnBonus;
  String? referEarnMethod;
  String? maxReferEarnAmount;
  String? minimumWithdrawalAmount;
  String? maxProductReturnDays;
  String? lowStockLimit;
  String? userWalletRefillLimit;
  String? taxName;
  String? taxNumber;
  String? deliveryBoyBonusMethod;
  String? deliveryBoyBonusPercentage;
  String? underMaintenanceSystem;
  String? ratings;
  String? localPickup;
  String? supportSystem;
  String? welcomeWalletBalance;
  String? walletBalance;
  String? fromMail;
  String? replyTo;
  String? smtpFromMail;
  String? smtpReplyTo;
  String? smtpEmailPassword;
  String? smtpHost;
  String? smtpPort;
  String? smtpContentType;
  String? smtpEncryptionType;
  String? aboutUs;
  String? deliveryBoyPrivacyPolicy;
  String? deliveryBoyTermsConditions;
  PaymentMethods? paymentMethods;
  TimeSlotConfig? timeSlotConfig;
  String? managerAppPrivacyPolicy;
  String? managerAppTermsConditions;
  String? refundPolicy;
  String? shippingPolicy;
  String? deliveryReturnsPolicy;
  CategoriesSettings? categoriesSettings;
  FrontEndSettings? frontEndSettings;
  String? frontEndAboutUs;

  Settings(
      {this.logo,
      this.privacyPolicy,
      this.termsConditions,
      this.fcmServerKey,
      this.contactUs,
      this.systemConfigurations,
      this.systemTimezoneGmt,
      this.systemConfigurationsId,
      this.appName,
      this.supportNumber,
      this.supportEmail,
      this.currentVersion,
      this.minimumVersionRequired,
      this.isVersionSystemOn,
      this.storeAddress,
      this.mapLatitude,
      this.mapLongitude,
      this.currency,
      this.systemTimezone,
      this.maxCartItemsCount,
      this.generateOtp,
      this.areaWiseDeliveryCharge,
      this.minAmount,
      this.minOrderAmount,
      this.deliveryCharge,
      this.isReferEarnOn,
      this.minReferEarnOrderAmount,
      this.referEarnBonus,
      this.referEarnMethod,
      this.maxReferEarnAmount,
      this.minimumWithdrawalAmount,
      this.maxProductReturnDays,
      this.lowStockLimit,
      this.userWalletRefillLimit,
      this.taxName,
      this.taxNumber,
      this.deliveryBoyBonusMethod,
      this.deliveryBoyBonusPercentage,
      this.underMaintenanceSystem,
      this.ratings,
      this.localPickup,
      this.supportSystem,
      this.welcomeWalletBalance,
      this.walletBalance,
      this.fromMail,
      this.replyTo,
      this.smtpFromMail,
      this.smtpReplyTo,
      this.smtpEmailPassword,
      this.smtpHost,
      this.smtpPort,
      this.smtpContentType,
      this.smtpEncryptionType,
      this.aboutUs,
      this.deliveryBoyPrivacyPolicy,
      this.deliveryBoyTermsConditions,
      this.paymentMethods,
      this.timeSlotConfig,
      this.managerAppPrivacyPolicy,
      this.managerAppTermsConditions,
      this.refundPolicy,
      this.shippingPolicy,
      this.deliveryReturnsPolicy,
      this.categoriesSettings,
      this.frontEndSettings,
      this.frontEndAboutUs});

  Settings.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    privacyPolicy = json['privacy_policy'];
    termsConditions = json['terms_conditions'];
    fcmServerKey = json['fcm_server_key'];
    contactUs = json['contact_us'];
    systemConfigurations = json['system_configurations'];
    systemTimezoneGmt = json['system_timezone_gmt'];
    systemConfigurationsId = json['system_configurations_id'];
    appName = json['app_name'];
    supportNumber = json['support_number'];
    supportEmail = json['support_email'];
    currentVersion = json['current_version'];
    minimumVersionRequired = json['minimum_version_required'];
    isVersionSystemOn = json['is-version-system-on'];
    storeAddress = json['store_address'];
    mapLatitude = json['map_latitude'];
    mapLongitude = json['map_longitude'];
    currency = json['currency'];
    systemTimezone = json['system_timezone'];
    maxCartItemsCount = json['max_cart_items_count'];
    generateOtp = json['generate-otp'];
    areaWiseDeliveryCharge = json['area-wise-delivery-charge'];
    minAmount = json['min_amount'];
    minOrderAmount = json['min_order_amount'];
    deliveryCharge = json['delivery_charge'];
    isReferEarnOn = json['is-refer-earn-on'];
    minReferEarnOrderAmount = json['min-refer-earn-order-amount'];
    referEarnBonus = json['refer-earn-bonus'];
    referEarnMethod = json['refer-earn-method'];
    maxReferEarnAmount = json['max-refer-earn-amount'];
    minimumWithdrawalAmount = json['minimum-withdrawal-amount'];
    maxProductReturnDays = json['max-product-return-days'];
    lowStockLimit = json['low-stock-limit'];
    userWalletRefillLimit = json['user-wallet-refill-limit'];
    taxName = json['tax_name'];
    taxNumber = json['tax_number'];
    deliveryBoyBonusMethod = json['delivery-boy-bonus-method'];
    deliveryBoyBonusPercentage = json['delivery-boy-bonus-percentage'];
    underMaintenanceSystem = json['under_maintenance_system'];
    ratings = json['ratings'];
    localPickup = json['local-pickup'];
    supportSystem = json['support_system'];
    welcomeWalletBalance = json['welcome-wallet-balance'];
    walletBalance = json['wallet_balance'];
    fromMail = json['from_mail'];
    replyTo = json['reply_to'];
    smtpFromMail = json['smtp-from-mail'];
    smtpReplyTo = json['smtp-reply-to'];
    smtpEmailPassword = json['smtp-email-password'];
    smtpHost = json['smtp-host'];
    smtpPort = json['smtp-port'];
    smtpContentType = json['smtp-content-type'];
    smtpEncryptionType = json['smtp-encryption-type'];
    aboutUs = json['about_us'];
    deliveryBoyPrivacyPolicy = json['delivery_boy_privacy_policy'];
    deliveryBoyTermsConditions = json['delivery_boy_terms_conditions'];
    paymentMethods = json['payment_methods'] != null
        ? new PaymentMethods.fromJson(json['payment_methods'])
        : null;
    timeSlotConfig = json['time_slot_config'] != null
        ? new TimeSlotConfig.fromJson(json['time_slot_config'])
        : null;
    managerAppPrivacyPolicy = json['manager_app_privacy_policy'];
    managerAppTermsConditions = json['manager_app_terms_conditions'];
    refundPolicy = json['refund_policy'];
    shippingPolicy = json['shipping_policy'];
    deliveryReturnsPolicy = json['delivery_returns_policy'];
    categoriesSettings = json['categories_settings'] != null
        ? new CategoriesSettings.fromJson(json['categories_settings'])
        : null;
    frontEndSettings = json['front_end_settings'] != null
        ? new FrontEndSettings.fromJson(json['front_end_settings'])
        : null;
    frontEndAboutUs = json['front_end_about_us'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo'] = this.logo;
    data['privacy_policy'] = this.privacyPolicy;
    data['terms_conditions'] = this.termsConditions;
    data['fcm_server_key'] = this.fcmServerKey;
    data['contact_us'] = this.contactUs;
    data['system_configurations'] = this.systemConfigurations;
    data['system_timezone_gmt'] = this.systemTimezoneGmt;
    data['system_configurations_id'] = this.systemConfigurationsId;
    data['app_name'] = this.appName;
    data['support_number'] = this.supportNumber;
    data['support_email'] = this.supportEmail;
    data['current_version'] = this.currentVersion;
    data['minimum_version_required'] = this.minimumVersionRequired;
    data['is-version-system-on'] = this.isVersionSystemOn;
    data['store_address'] = this.storeAddress;
    data['map_latitude'] = this.mapLatitude;
    data['map_longitude'] = this.mapLongitude;
    data['currency'] = this.currency;
    data['system_timezone'] = this.systemTimezone;
    data['max_cart_items_count'] = this.maxCartItemsCount;
    data['generate-otp'] = this.generateOtp;
    data['area-wise-delivery-charge'] = this.areaWiseDeliveryCharge;
    data['min_amount'] = this.minAmount;
    data['min_order_amount'] = this.minOrderAmount;
    data['delivery_charge'] = this.deliveryCharge;
    data['is-refer-earn-on'] = this.isReferEarnOn;
    data['min-refer-earn-order-amount'] = this.minReferEarnOrderAmount;
    data['refer-earn-bonus'] = this.referEarnBonus;
    data['refer-earn-method'] = this.referEarnMethod;
    data['max-refer-earn-amount'] = this.maxReferEarnAmount;
    data['minimum-withdrawal-amount'] = this.minimumWithdrawalAmount;
    data['max-product-return-days'] = this.maxProductReturnDays;
    data['low-stock-limit'] = this.lowStockLimit;
    data['user-wallet-refill-limit'] = this.userWalletRefillLimit;
    data['tax_name'] = this.taxName;
    data['tax_number'] = this.taxNumber;
    data['delivery-boy-bonus-method'] = this.deliveryBoyBonusMethod;
    data['delivery-boy-bonus-percentage'] = this.deliveryBoyBonusPercentage;
    data['under_maintenance_system'] = this.underMaintenanceSystem;
    data['ratings'] = this.ratings;
    data['local-pickup'] = this.localPickup;
    data['support_system'] = this.supportSystem;
    data['welcome-wallet-balance'] = this.welcomeWalletBalance;
    data['wallet_balance'] = this.walletBalance;
    data['from_mail'] = this.fromMail;
    data['reply_to'] = this.replyTo;
    data['smtp-from-mail'] = this.smtpFromMail;
    data['smtp-reply-to'] = this.smtpReplyTo;
    data['smtp-email-password'] = this.smtpEmailPassword;
    data['smtp-host'] = this.smtpHost;
    data['smtp-port'] = this.smtpPort;
    data['smtp-content-type'] = this.smtpContentType;
    data['smtp-encryption-type'] = this.smtpEncryptionType;
    data['about_us'] = this.aboutUs;
    data['delivery_boy_privacy_policy'] = this.deliveryBoyPrivacyPolicy;
    data['delivery_boy_terms_conditions'] = this.deliveryBoyTermsConditions;
    if (this.paymentMethods != null) {
      data['payment_methods'] = this.paymentMethods!.toJson();
    }
    if (this.timeSlotConfig != null) {
      data['time_slot_config'] = this.timeSlotConfig!.toJson();
    }
    data['manager_app_privacy_policy'] = this.managerAppPrivacyPolicy;
    data['manager_app_terms_conditions'] = this.managerAppTermsConditions;
    data['refund_policy'] = this.refundPolicy;
    data['shipping_policy'] = this.shippingPolicy;
    data['delivery_returns_policy'] = this.deliveryReturnsPolicy;
    if (this.categoriesSettings != null) {
      data['categories_settings'] = this.categoriesSettings!.toJson();
    }
    if (this.frontEndSettings != null) {
      data['front_end_settings'] = this.frontEndSettings!.toJson();
    }
    data['front_end_about_us'] = this.frontEndAboutUs;
    return data;
  }
}

class PaymentMethods {
  String? paymentMethodSettings;
  String? codPaymentMethod;
  String? codMode;
  String? paypalPaymentMethod;
  String? paypalMode;
  String? paypalCurrencyCode;
  String? paypalBusinessEmail;
  String? payumoneyPaymentMethod;
  String? payumoneyMode;
  String? payumoneyMerchantKey;
  String? payumoneyMerchantId;
  String? payumoneySalt;
  String? razorpayPaymentMethod;
  String? razorpayKey;
  String? razorpaySecretKey;
  String? paystackPaymentMethod;
  String? paystackPublicKey;
  String? paystackSecretKey;
  String? flutterwavePaymentMethod;
  String? flutterwavePublicKey;
  String? flutterwaveSecretKey;
  String? flutterwaveEncryptionKey;
  String? flutterwaveCurrencyCode;
  String? midtransPaymentMethod;
  String? isProduction;
  String? midtransMerchantId;
  String? midtransClientKey;
  String? midtransServerKey;
  String? stripePaymentMethod;
  String? stripePublishableKey;
  String? stripeSecretKey;
  String? stripeWebhookSecretKey;
  String? stripeCurrencyCode;
  String? paytmPaymentMethod;
  String? paytmMode;
  String? paytmMerchantKey;
  String? paytmMerchantId;
  String? sslMethod;
  String? sslMode;
  String? sslStoreId;
  String? sslStorePassword;
  String? directBankTransferMethod;
  String? accountName;
  String? accountNumber;
  String? bankName;
  String? bankCode;
  String? notes;

  PaymentMethods(
      {this.paymentMethodSettings,
      this.codPaymentMethod,
      this.codMode,
      this.paypalPaymentMethod,
      this.paypalMode,
      this.paypalCurrencyCode,
      this.paypalBusinessEmail,
      this.payumoneyPaymentMethod,
      this.payumoneyMode,
      this.payumoneyMerchantKey,
      this.payumoneyMerchantId,
      this.payumoneySalt,
      this.razorpayPaymentMethod,
      this.razorpayKey,
      this.razorpaySecretKey,
      this.paystackPaymentMethod,
      this.paystackPublicKey,
      this.paystackSecretKey,
      this.flutterwavePaymentMethod,
      this.flutterwavePublicKey,
      this.flutterwaveSecretKey,
      this.flutterwaveEncryptionKey,
      this.flutterwaveCurrencyCode,
      this.midtransPaymentMethod,
      this.isProduction,
      this.midtransMerchantId,
      this.midtransClientKey,
      this.midtransServerKey,
      this.stripePaymentMethod,
      this.stripePublishableKey,
      this.stripeSecretKey,
      this.stripeWebhookSecretKey,
      this.stripeCurrencyCode,
      this.paytmPaymentMethod,
      this.paytmMode,
      this.paytmMerchantKey,
      this.paytmMerchantId,
      this.sslMethod,
      this.sslMode,
      this.sslStoreId,
      this.sslStorePassword,
      this.directBankTransferMethod,
      this.accountName,
      this.accountNumber,
      this.bankName,
      this.bankCode,
      this.notes});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    paymentMethodSettings = json['payment_method_settings'];
    codPaymentMethod = json['cod_payment_method'];
    codMode = json['cod_mode'];
    paypalPaymentMethod = json['paypal_payment_method'];
    paypalMode = json['paypal_mode'];
    paypalCurrencyCode = json['paypal_currency_code'];
    paypalBusinessEmail = json['paypal_business_email'];
    payumoneyPaymentMethod = json['payumoney_payment_method'];
    payumoneyMode = json['payumoney_mode'];
    payumoneyMerchantKey = json['payumoney_merchant_key'];
    payumoneyMerchantId = json['payumoney_merchant_id'];
    payumoneySalt = json['payumoney_salt'];
    razorpayPaymentMethod = json['razorpay_payment_method'];
    razorpayKey = json['razorpay_key'];
    razorpaySecretKey = json['razorpay_secret_key'];
    paystackPaymentMethod = json['paystack_payment_method'];
    paystackPublicKey = json['paystack_public_key'];
    paystackSecretKey = json['paystack_secret_key'];
    flutterwavePaymentMethod = json['flutterwave_payment_method'];
    flutterwavePublicKey = json['flutterwave_public_key'];
    flutterwaveSecretKey = json['flutterwave_secret_key'];
    flutterwaveEncryptionKey = json['flutterwave_encryption_key'];
    flutterwaveCurrencyCode = json['flutterwave_currency_code'];
    midtransPaymentMethod = json['midtrans_payment_method'];
    isProduction = json['is_production'];
    midtransMerchantId = json['midtrans_merchant_id'];
    midtransClientKey = json['midtrans_client_key'];
    midtransServerKey = json['midtrans_server_key'];
    stripePaymentMethod = json['stripe_payment_method'];
    stripePublishableKey = json['stripe_publishable_key'];
    stripeSecretKey = json['stripe_secret_key'];
    stripeWebhookSecretKey = json['stripe_webhook_secret_key'];
    stripeCurrencyCode = json['stripe_currency_code'];
    paytmPaymentMethod = json['paytm_payment_method'];
    paytmMode = json['paytm_mode'];
    paytmMerchantKey = json['paytm_merchant_key'];
    paytmMerchantId = json['paytm_merchant_id'];
    sslMethod = json['ssl_method'];
    sslMode = json['ssl_mode'];
    sslStoreId = json['ssl_store_id'];
    sslStorePassword = json['ssl_store_password'];
    directBankTransferMethod = json['direct_bank_transfer_method'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    bankCode = json['bank_code'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method_settings'] = this.paymentMethodSettings;
    data['cod_payment_method'] = this.codPaymentMethod;
    data['cod_mode'] = this.codMode;
    data['paypal_payment_method'] = this.paypalPaymentMethod;
    data['paypal_mode'] = this.paypalMode;
    data['paypal_currency_code'] = this.paypalCurrencyCode;
    data['paypal_business_email'] = this.paypalBusinessEmail;
    data['payumoney_payment_method'] = this.payumoneyPaymentMethod;
    data['payumoney_mode'] = this.payumoneyMode;
    data['payumoney_merchant_key'] = this.payumoneyMerchantKey;
    data['payumoney_merchant_id'] = this.payumoneyMerchantId;
    data['payumoney_salt'] = this.payumoneySalt;
    data['razorpay_payment_method'] = this.razorpayPaymentMethod;
    data['razorpay_key'] = this.razorpayKey;
    data['razorpay_secret_key'] = this.razorpaySecretKey;
    data['paystack_payment_method'] = this.paystackPaymentMethod;
    data['paystack_public_key'] = this.paystackPublicKey;
    data['paystack_secret_key'] = this.paystackSecretKey;
    data['flutterwave_payment_method'] = this.flutterwavePaymentMethod;
    data['flutterwave_public_key'] = this.flutterwavePublicKey;
    data['flutterwave_secret_key'] = this.flutterwaveSecretKey;
    data['flutterwave_encryption_key'] = this.flutterwaveEncryptionKey;
    data['flutterwave_currency_code'] = this.flutterwaveCurrencyCode;
    data['midtrans_payment_method'] = this.midtransPaymentMethod;
    data['is_production'] = this.isProduction;
    data['midtrans_merchant_id'] = this.midtransMerchantId;
    data['midtrans_client_key'] = this.midtransClientKey;
    data['midtrans_server_key'] = this.midtransServerKey;
    data['stripe_payment_method'] = this.stripePaymentMethod;
    data['stripe_publishable_key'] = this.stripePublishableKey;
    data['stripe_secret_key'] = this.stripeSecretKey;
    data['stripe_webhook_secret_key'] = this.stripeWebhookSecretKey;
    data['stripe_currency_code'] = this.stripeCurrencyCode;
    data['paytm_payment_method'] = this.paytmPaymentMethod;
    data['paytm_mode'] = this.paytmMode;
    data['paytm_merchant_key'] = this.paytmMerchantKey;
    data['paytm_merchant_id'] = this.paytmMerchantId;
    data['ssl_method'] = this.sslMethod;
    data['ssl_mode'] = this.sslMode;
    data['ssl_store_id'] = this.sslStoreId;
    data['ssl_store_password'] = this.sslStorePassword;
    data['direct_bank_transfer_method'] = this.directBankTransferMethod;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['bank_name'] = this.bankName;
    data['bank_code'] = this.bankCode;
    data['notes'] = this.notes;
    return data;
  }
}

class TimeSlotConfig {
  String? timeSlotConfig;
  String? isTimeSlotsEnabled;
  String? deliveryStartsFrom;
  String? allowedDays;

  TimeSlotConfig(
      {this.timeSlotConfig,
      this.isTimeSlotsEnabled,
      this.deliveryStartsFrom,
      this.allowedDays});

  TimeSlotConfig.fromJson(Map<String, dynamic> json) {
    timeSlotConfig = json['time_slot_config'];
    isTimeSlotsEnabled = json['is_time_slots_enabled'];
    deliveryStartsFrom = json['delivery_starts_from'];
    allowedDays = json['allowed_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_slot_config'] = this.timeSlotConfig;
    data['is_time_slots_enabled'] = this.isTimeSlotsEnabled;
    data['delivery_starts_from'] = this.deliveryStartsFrom;
    data['allowed_days'] = this.allowedDays;
    return data;
  }
}

class CategoriesSettings {
  String? addCategorySettings;
  String? catStyle;
  String? maxVisibleCategories;
  String? maxColInSingleRow;

  CategoriesSettings(
      {this.addCategorySettings,
      this.catStyle,
      this.maxVisibleCategories,
      this.maxColInSingleRow});

  CategoriesSettings.fromJson(Map<String, dynamic> json) {
    addCategorySettings = json['add_category_settings'];
    catStyle = json['cat_style'];
    maxVisibleCategories = json['max_visible_categories'];
    maxColInSingleRow = json['max_col_in_single_row'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['add_category_settings'] = this.addCategorySettings;
    data['cat_style'] = this.catStyle;
    data['max_visible_categories'] = this.maxVisibleCategories;
    data['max_col_in_single_row'] = this.maxColInSingleRow;
    return data;
  }
}

class FrontEndSettings {
  String? frontEndSettings;
  String? androidAppUrl;
  String? callBackUrl;
  String? copyRightTitle;
  String? copyRightUrl;
  String? commonMetaKeywords;
  String? commonMetaDescription;
  String? showColorPickerInWebsite;
  String? color;
  String? showThemeOnWebsite;
  String? favicon;
  String? webLogo;
  String? loading;
  String? screenshots;
  String? googlePlay;

  FrontEndSettings(
      {this.frontEndSettings,
      this.androidAppUrl,
      this.callBackUrl,
      this.copyRightTitle,
      this.copyRightUrl,
      this.commonMetaKeywords,
      this.commonMetaDescription,
      this.showColorPickerInWebsite,
      this.color,
      this.showThemeOnWebsite,
      this.favicon,
      this.webLogo,
      this.loading,
      this.screenshots,
      this.googlePlay});

  FrontEndSettings.fromJson(Map<String, dynamic> json) {
    frontEndSettings = json['front_end_settings'];
    androidAppUrl = json['android_app_url'];
    callBackUrl = json['call_back_url'];
    copyRightTitle = json['copy_right_title'];
    copyRightUrl = json['copy_right_url'];
    commonMetaKeywords = json['common_meta_keywords'];
    commonMetaDescription = json['common_meta_description'];
    showColorPickerInWebsite = json['show_color_picker_in_website'];
    color = json['color'];
    showThemeOnWebsite = json['show_theme_on_website'];
    favicon = json['favicon'];
    webLogo = json['web_logo'];
    loading = json['loading'];
    screenshots = json['screenshots'];
    googlePlay = json['google_play'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['front_end_settings'] = this.frontEndSettings;
    data['android_app_url'] = this.androidAppUrl;
    data['call_back_url'] = this.callBackUrl;
    data['copy_right_title'] = this.copyRightTitle;
    data['copy_right_url'] = this.copyRightUrl;
    data['common_meta_keywords'] = this.commonMetaKeywords;
    data['common_meta_description'] = this.commonMetaDescription;
    data['show_color_picker_in_website'] = this.showColorPickerInWebsite;
    data['color'] = this.color;
    data['show_theme_on_website'] = this.showThemeOnWebsite;
    data['favicon'] = this.favicon;
    data['web_logo'] = this.webLogo;
    data['loading'] = this.loading;
    data['screenshots'] = this.screenshots;
    data['google_play'] = this.googlePlay;
    return data;
  }
}
