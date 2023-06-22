class Product {
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
  List<Variants> variants;

  Product(
      {required this.id,
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
      required this.variants});

  factory Product.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final indicator = json['indicator'];
    final image = json['image'];
    final ratings = json['ratings'];
    final numberOfRatings = json['number_of_ratings'];
    final totalAllowedQuantity = json['total_allowed_quantity'];
    final slug = json['slug'];
    final description = json['description'];
    final status = json['status'];
    final categoryName = json['category_name'];
    final taxPercentage = json['tax_percentage'];
    final price = json['price'];
    final isFavorite = json['is_favorite'];
    final variants = <Variants>[];
    if (json['variants'] != null) {
      json['variants'].forEach((v) {
        variants.add(new Variants.fromJson(v));
      });
    }

    return Product(
        id: id,
        name: name,
        indicator: indicator,
        image: image,
        ratings: ratings,
        numberOfRatings: numberOfRatings,
        totalAllowedQuantity: totalAllowedQuantity,
        slug: slug,
        description: description,
        status: status,
        categoryName: categoryName,
        taxPercentage: taxPercentage,
        price: price,
        isFavorite: isFavorite,
        variants: variants);
  }
}

class Variants {
  String? type;
  String? id;
  String? productId;
  String? price;
  String? discountedPrice;
  String? serveFor;
  String? stock;
  String? measurement;
  String? measurementUnitName;
  String? stockUnitName;
  List<String>? images;
  String? cartCount;
  bool? isFlashSales;

  Variants(
      {this.type,
      this.id,
      this.productId,
      this.price,
      this.discountedPrice,
      this.serveFor,
      this.stock,
      this.measurement,
      this.measurementUnitName,
      this.stockUnitName,
      this.images,
      this.cartCount,
      this.isFlashSales});

  Variants.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    productId = json['product_id'];
    price = json['price'];
    discountedPrice = json['discounted_price'];
    serveFor = json['serve_for'];
    stock = json['stock'];
    measurement = json['measurement'];
    measurementUnitName = json['measurement_unit_name'];
    stockUnitName = json['stock_unit_name'];
    if (json['images'] != null) {
      // images = <Null>[];
      json['images'].forEach((v) {
        // images!.add(new Null.fromJson(v));
      });
    }
    cartCount = json['cart_count'];
    isFlashSales = json['is_flash_sales'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> product = <String, dynamic>{};
    product['type'] = type;
    product['id'] = id;
    product['product_id'] = productId;
    product['price'] = price;
    product['discounted_price'] = discountedPrice;
    product['serve_for'] = serveFor;
    product['stock'] = stock;
    product['measurement'] = measurement;
    product['measurement_unit_name'] = measurementUnitName;
    product['stock_unit_name'] = stockUnitName;
    if (images != null) {
      // product['images'] = images!.map((v) => v.toJson()).toList();
    }
    product['cart_count'] = cartCount;
    product['is_flash_sales'] = isFlashSales;
    return product;
  }
}
