class ReorderData {
  bool? error;
  String? message;
  Data? data;

  ReorderData({this.error, this.message, this.data});

  ReorderData.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? userId;
  String? deliveryBoyId;
  String? otp;
  String? mobile;
  String? orderNote;
  String? total;
  String? deliveryCharge;
  String? taxAmount;
  String? taxPercentage;
  String? walletBalance;
  String? discount;
  String? promoCode;
  String? promoDiscount;
  String? finalTotal;
  String? paymentMethod;
  String? address;
  String? latitude;
  String? longitude;
  String? deliveryTime;
  String? sellerNotes;
  String? localPickup;
  String? pickupTime;
  String? activeStatus;
  String? dateAdded;
  String? orderFrom;
  List<Items>? items;

  Data(
      {this.id,
      this.userId,
      this.deliveryBoyId,
      this.otp,
      this.mobile,
      this.orderNote,
      this.total,
      this.deliveryCharge,
      this.taxAmount,
      this.taxPercentage,
      this.walletBalance,
      this.discount,
      this.promoCode,
      this.promoDiscount,
      this.finalTotal,
      this.paymentMethod,
      this.address,
      this.latitude,
      this.longitude,
      this.deliveryTime,
      this.sellerNotes,
      this.localPickup,
      this.pickupTime,
      this.activeStatus,
      this.dateAdded,
      this.orderFrom,
      this.items});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    deliveryBoyId = json['delivery_boy_id'];
    otp = json['otp'];
    mobile = json['mobile'];
    orderNote = json['order_note'];
    total = json['total'];
    deliveryCharge = json['delivery_charge'];
    taxAmount = json['tax_amount'];
    taxPercentage = json['tax_percentage'];
    walletBalance = json['wallet_balance'];
    discount = json['discount'];
    promoCode = json['promo_code'];
    promoDiscount = json['promo_discount'];
    finalTotal = json['final_total'];
    paymentMethod = json['payment_method'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    deliveryTime = json['delivery_time'];
    sellerNotes = json['seller_notes'];
    localPickup = json['local_pickup'];
    pickupTime = json['pickup_time'];
    activeStatus = json['active_status'];
    dateAdded = json['date_added'];
    orderFrom = json['order_from'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['delivery_boy_id'] = this.deliveryBoyId;
    data['otp'] = this.otp;
    data['mobile'] = this.mobile;
    data['order_note'] = this.orderNote;
    data['total'] = this.total;
    data['delivery_charge'] = this.deliveryCharge;
    data['tax_amount'] = this.taxAmount;
    data['tax_percentage'] = this.taxPercentage;
    data['wallet_balance'] = this.walletBalance;
    data['discount'] = this.discount;
    data['promo_code'] = this.promoCode;
    data['promo_discount'] = this.promoDiscount;
    data['final_total'] = this.finalTotal;
    data['payment_method'] = this.paymentMethod;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['delivery_time'] = this.deliveryTime;
    data['seller_notes'] = this.sellerNotes;
    data['local_pickup'] = this.localPickup;
    data['pickup_time'] = this.pickupTime;
    data['active_status'] = this.activeStatus;
    data['date_added'] = this.dateAdded;
    data['order_from'] = this.orderFrom;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? productVariantId;
  String? quantity;

  Items({this.productVariantId, this.quantity});

  Items.fromJson(Map<String, dynamic> json) {
    productVariantId = json['product_variant_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_variant_id'] = this.productVariantId;
    data['quantity'] = this.quantity;
    return data;
  }
}
