// To parse this JSON data, do
//
//     final getWalletHistoryResponseModel = getWalletHistoryResponseModelFromJson(jsonString);

import 'dart:convert';

GetWalletHistoryResponseModel getWalletHistoryResponseModelFromJson(String str) => GetWalletHistoryResponseModel.fromJson(json.decode(str));

String getWalletHistoryResponseModelToJson(GetWalletHistoryResponseModel data) => json.encode(data.toJson());

class GetWalletHistoryResponseModel {
  GetWalletHistoryResponseModel({
    required this.error,
    required this.total,
    required this.data,
  });

  bool error;
  String total;
  List<Datum> data;

  factory GetWalletHistoryResponseModel.fromJson(Map<String, dynamic> json) => GetWalletHistoryResponseModel(
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
    required this.id,
    required this.orderId,
    required this.userId,
    required this.type,
    required this.amount,
    required this.message,
    required this.status,
    required this.dateCreated,
    required this.lastUpdated,
    required this.payuTxnId,
    required this.txnId,
  });

  String id;
  String orderId;
  String userId;
  String type;
  String amount;
  String message;
  String status;
  DateTime dateCreated;
  String lastUpdated;
  String payuTxnId;
  String txnId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    orderId: json["order_id"],
    userId: json["user_id"],
    type: json["type"],
    amount: json["amount"],
    message: json["message"],
    status: json["status"],
    dateCreated: DateTime.parse(json["date_created"]),
    lastUpdated: json["last_updated"],
    payuTxnId: json["payu_txn_id"],
    txnId: json["txn_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "user_id": userId,
    "type": type,
    "amount": amount,
    "message": message,
    "status": status,
    "date_created": dateCreated.toIso8601String(),
    "last_updated": lastUpdated,
    "payu_txn_id": payuTxnId,
    "txn_id": txnId,
  };
}
