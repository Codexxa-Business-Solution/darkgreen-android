// To parse this JSON data, do
//
//     final getOredersStatusResponseModel = getOredersStatusResponseModelFromJson(jsonString);

import 'dart:convert';

GetOredersStatusResponseModel getOrdersStatusResponseModelFromJson(String str) => GetOredersStatusResponseModel.fromJson(json.decode(str));

String getOredersStatusResponseModelToJson(GetOredersStatusResponseModel data) => json.encode(data.toJson());

class GetOredersStatusResponseModel {
  bool error;
  String total;
  List<Datum> data;

  GetOredersStatusResponseModel({
    required this.error,
    required this.total,
    required this.data,
  });

  factory GetOredersStatusResponseModel.fromJson(Map<String, dynamic> json) => GetOredersStatusResponseModel(
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
  String id;
  String userId;
  String deliveryBoyId;
  String otp;
  String mobile;
  String orderNote;
  String total;
  String deliveryCharge;
  String taxAmount;
  String taxPercentage;
  String walletBalance;
  String discount;
  String promoCode;
  String promoDiscount;
  String finalTotal;
  String paymentMethod;
  String address;
  String latitude;
  String longitude;
  String deliveryTime;
  String sellerNotes;
  String localPickup;
  String pickupTime;
  List<dynamic> status;
  String activeStatus;
  String dateAdded;
  String orderFrom;
  List<dynamic> attachment;
  String totalAttachment;
  String bankTransferMessage;
  String bankTransferStatus;
  String userName;
  String discountRupees;
  DateTime orderTime;
  List<dynamic> statusName;
  List<dynamic> statusTime;
  List<Item> items;

  Datum({
    required this.id,
    required this.userId,
    required this.deliveryBoyId,
    required this.otp,
    required this.mobile,
    required this.orderNote,
    required this.total,
    required this.deliveryCharge,
    required this.taxAmount,
    required this.taxPercentage,
    required this.walletBalance,
    required this.discount,
    required this.promoCode,
    required this.promoDiscount,
    required this.finalTotal,
    required this.paymentMethod,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.deliveryTime,
    required this.sellerNotes,
    required this.localPickup,
    required this.pickupTime,
    required this.status,
    required this.activeStatus,
    required this.dateAdded,
    required this.orderFrom,
    required this.attachment,
    required this.totalAttachment,
    required this.bankTransferMessage,
    required this.bankTransferStatus,
    required this.userName,
    required this.discountRupees,
    required this.orderTime,
    required this.statusName,
    required this.statusTime,
    required this.items,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    deliveryBoyId: json["delivery_boy_id"],
    otp: json["otp"],
    mobile: json["mobile"],
    orderNote: json["order_note"],
    total: json["total"],
    deliveryCharge: json["delivery_charge"],
    taxAmount: json["tax_amount"],
    taxPercentage: json["tax_percentage"],
    walletBalance: json["wallet_balance"],
    discount: json["discount"],
    promoCode: json["promo_code"],
    promoDiscount: json["promo_discount"],
    finalTotal: json["final_total"],
    paymentMethod: json["payment_method"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    deliveryTime: json["delivery_time"],
    sellerNotes: json["seller_notes"],
    localPickup: json["local_pickup"],
    pickupTime: json["pickup_time"],
    status: List<dynamic>.from(json["status"].map((x) => x)),
    activeStatus: json["active_status"],
    dateAdded: json["date_added"],
    orderFrom: json["order_from"],
    attachment: List<dynamic>.from(json["attachment"].map((x) => x)),
    totalAttachment: json["total_attachment"],
    bankTransferMessage: json["bank_transfer_message"],
    bankTransferStatus: json["bank_transfer_status"],
    userName: json["user_name"],
    discountRupees: json["discount_rupees"],
    orderTime: DateTime.parse(json["order_time"]),
    statusName: List<dynamic>.from(json["status_name"].map((x) => x)),
    statusTime: List<dynamic>.from(json["status_time"].map((x) => x)),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "delivery_boy_id": deliveryBoyId,
    "otp": otp,
    "mobile": mobile,
    "order_note": orderNote,
    "total": total,
    "delivery_charge": deliveryCharge,
    "tax_amount": taxAmount,
    "tax_percentage": taxPercentage,
    "wallet_balance": walletBalance,
    "discount": discount,
    "promo_code": promoCode,
    "promo_discount": promoDiscount,
    "final_total": finalTotal,
    "payment_method": paymentMethod,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "delivery_time": deliveryTime,
    "seller_notes": sellerNotes,
    "local_pickup": localPickup,
    "pickup_time": pickupTime,
    "status": List<dynamic>.from(status.map((x) => x)),
    "active_status": activeStatus,
    "date_added": dateAdded,
    "order_from": orderFrom,
    "attachment": List<dynamic>.from(attachment.map((x) => x)),
    "total_attachment": totalAttachment,
    "bank_transfer_message": bankTransferMessage,
    "bank_transfer_status": bankTransferStatus,
    "user_name": userName,
    "discount_rupees": discountRupees,
    "order_time": orderTime.toIso8601String(),
    "status_name": List<dynamic>.from(statusName.map((x) => x)),
    "status_time": List<dynamic>.from(statusTime.map((x) => x)),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  String id;
  String userId;
  String orderId;
  String productId;
  String productVariantId;
  String productName;
  String variantName;
  String quantity;
  String price;
  String discountedPrice;
  String taxAmount;
  String taxPercentage;
  String discount;
  String subTotal;
  String deliverBy;
  List<dynamic> status;
  String activeStatus;
  DateTime dateAdded;
  dynamic hsnCode;
  String variantId;
  String rate;
  String review;
  bool reviewStatus;
  String name;
  String image;
  String manufacturer;
  String madeIn;
  String returnStatus;
  String cancelableStatus;
  String tillStatus;
  String measurement;
  String unit;
  bool appliedForReturn;

  Item({
    required this.id,
    required this.userId,
    required this.orderId,
    required this.productId,
    required this.productVariantId,
    required this.productName,
    required this.variantName,
    required this.quantity,
    required this.price,
    required this.discountedPrice,
    required this.taxAmount,
    required this.taxPercentage,
    required this.discount,
    required this.subTotal,
    required this.deliverBy,
    required this.status,
    required this.activeStatus,
    required this.dateAdded,
    this.hsnCode,
    required this.variantId,
    required this.rate,
    required this.review,
    required this.reviewStatus,
    required this.name,
    required this.image,
    required this.manufacturer,
    required this.madeIn,
    required this.returnStatus,
    required this.cancelableStatus,
    required this.tillStatus,
    required this.measurement,
    required this.unit,
    required this.appliedForReturn,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    userId: json["user_id"],
    orderId: json["order_id"],
    productId: json["product_id"],
    productVariantId: json["product_variant_id"],
    productName: json["product_name"],
    variantName: json["variant_name"],
    quantity: json["quantity"],
    price: json["price"],
    discountedPrice: json["discounted_price"],
    taxAmount: json["tax_amount"],
    taxPercentage: json["tax_percentage"],
    discount: json["discount"],
    subTotal: json["sub_total"],
    deliverBy: json["deliver_by"],
    status: List<dynamic>.from(json["status"].map((x) => x)),
    activeStatus: json["active_status"],
    dateAdded: DateTime.parse(json["date_added"]),
    hsnCode: json["hsn_code"],
    variantId: json["variant_id"],
    rate: json["rate"],
    review: json["review"],
    reviewStatus: json["review_status"],
    name: json["name"],
    image: json["image"],
    manufacturer: json["manufacturer"],
    madeIn: json["made_in"],
    returnStatus: json["return_status"],
    cancelableStatus: json["cancelable_status"],
    tillStatus: json["till_status"],
    measurement: json["measurement"],
    unit: json["unit"],
    appliedForReturn: json["applied_for_return"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "order_id": orderId,
    "product_id": productId,
    "product_variant_id": productVariantId,
    "product_name": productName,
    "variant_name": variantName,
    "quantity": quantity,
    "price": price,
    "discounted_price": discountedPrice,
    "tax_amount": taxAmount,
    "tax_percentage": taxPercentage,
    "discount": discount,
    "sub_total": subTotal,
    "deliver_by": deliverBy,
    "status": List<dynamic>.from(status.map((x) => x)),
    "active_status": activeStatus,
    "date_added": dateAdded.toIso8601String(),
    "hsn_code": hsnCode,
    "variant_id": variantId,
    "rate": rate,
    "review": review,
    "review_status": reviewStatus,
    "name": name,
    "image": image,
    "manufacturer": manufacturer,
    "made_in": madeIn,
    "return_status": returnStatus,
    "cancelable_status": cancelableStatus,
    "till_status": tillStatus,
    "measurement": measurement,
    "unit": unit,
    "applied_for_return": appliedForReturn,
  };
}
