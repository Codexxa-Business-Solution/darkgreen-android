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

    return Product(id: id, name: name, indicator: indicator, image: image, ratings: ratings, numberOfRatings: numberOfRatings, totalAllowedQuantity: totalAllowedQuantity, slug: slug, description: description, status: status, categoryName: categoryName, taxPercentage: taxPercentage, price: price, isFavorite: isFavorite, variants: variants);
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
        this.isFlashSales
      });

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
    final Map<String, dynamic> Product = new Map<String, dynamic>();
    Product['type'] = this.type;
    Product['id'] = this.id;
    Product['product_id'] = this.productId;
    Product['price'] = this.price;
    Product['discounted_price'] = this.discountedPrice;
    Product['serve_for'] = this.serveFor;
    Product['stock'] = this.stock;
    Product['measurement'] = this.measurement;
    Product['measurement_unit_name'] = this.measurementUnitName;
    Product['stock_unit_name'] = this.stockUnitName;
    if (this.images != null) {
      // Product['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    Product['cart_count'] = this.cartCount;
    Product['is_flash_sales'] = this.isFlashSales;
    return Product;
  }
}
