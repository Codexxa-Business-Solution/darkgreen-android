// To parse this JSON data, do
//
//     final getPaymentMethodResponseModel = getPaymentMethodResponseModelFromJson(jsonString);

import 'dart:convert';

GetPaymentMethodResponseModel getPaymentMethodResponseModelFromJson(String str) => GetPaymentMethodResponseModel.fromJson(json.decode(str));

String getPaymentMethodResponseModelToJson(GetPaymentMethodResponseModel data) => json.encode(data.toJson());

class GetPaymentMethodResponseModel {
  bool error;
  PaymentMethods paymentMethods;

  GetPaymentMethodResponseModel({
    required this.error,
    required this.paymentMethods,
  });

  factory GetPaymentMethodResponseModel.fromJson(Map<String, dynamic> json) => GetPaymentMethodResponseModel(
    error: json["error"],
    paymentMethods: PaymentMethods.fromJson(json["payment_methods"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "payment_methods": paymentMethods.toJson(),
  };
}

class PaymentMethods {
  String paymentMethodSettings;
  String codPaymentMethod;
  String codMode;
  String paypalPaymentMethod;
  String paypalMode;
  String paypalCurrencyCode;
  String paypalBusinessEmail;
  String payumoneyPaymentMethod;
  String payumoneyMode;
  String payumoneyMerchantKey;
  String payumoneyMerchantId;
  String payumoneySalt;
  String razorpayPaymentMethod;
  String razorpayKey;
  String razorpaySecretKey;
  String paystackPaymentMethod;
  String paystackPublicKey;
  String paystackSecretKey;
  String flutterwavePaymentMethod;
  String flutterwavePublicKey;
  String flutterwaveSecretKey;
  String flutterwaveEncryptionKey;
  String flutterwaveCurrencyCode;
  String midtransPaymentMethod;
  String isProduction;
  String midtransMerchantId;
  String midtransClientKey;
  String midtransServerKey;
  String stripePaymentMethod;
  String stripePublishableKey;
  String stripeSecretKey;
  String stripeWebhookSecretKey;
  String stripeCurrencyCode;
  String paytmPaymentMethod;
  String paytmMode;
  String paytmMerchantKey;
  String paytmMerchantId;
  String sslMethod;
  String sslMode;
  String sslStoreId;
  String sslStorePassword;
  String directBankTransferMethod;
  String accountName;
  String accountNumber;
  String bankName;
  String bankCode;
  String notes;

  PaymentMethods({
    required this.paymentMethodSettings,
    required this.codPaymentMethod,
    required this.codMode,
    required this.paypalPaymentMethod,
    required this.paypalMode,
    required this.paypalCurrencyCode,
    required this.paypalBusinessEmail,
    required this.payumoneyPaymentMethod,
    required this.payumoneyMode,
    required this.payumoneyMerchantKey,
    required this.payumoneyMerchantId,
    required this.payumoneySalt,
    required this.razorpayPaymentMethod,
    required this.razorpayKey,
    required this.razorpaySecretKey,
    required this.paystackPaymentMethod,
    required this.paystackPublicKey,
    required this.paystackSecretKey,
    required this.flutterwavePaymentMethod,
    required this.flutterwavePublicKey,
    required this.flutterwaveSecretKey,
    required this.flutterwaveEncryptionKey,
    required this.flutterwaveCurrencyCode,
    required this.midtransPaymentMethod,
    required this.isProduction,
    required this.midtransMerchantId,
    required this.midtransClientKey,
    required this.midtransServerKey,
    required this.stripePaymentMethod,
    required this.stripePublishableKey,
    required this.stripeSecretKey,
    required this.stripeWebhookSecretKey,
    required this.stripeCurrencyCode,
    required this.paytmPaymentMethod,
    required this.paytmMode,
    required this.paytmMerchantKey,
    required this.paytmMerchantId,
    required this.sslMethod,
    required this.sslMode,
    required this.sslStoreId,
    required this.sslStorePassword,
    required this.directBankTransferMethod,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.bankCode,
    required this.notes,
  });

  factory PaymentMethods.fromJson(Map<String, dynamic> json) => PaymentMethods(
    paymentMethodSettings: json["payment_method_settings"],
    codPaymentMethod: json["cod_payment_method"],
    codMode: json["cod_mode"],
    paypalPaymentMethod: json["paypal_payment_method"],
    paypalMode: json["paypal_mode"],
    paypalCurrencyCode: json["paypal_currency_code"],
    paypalBusinessEmail: json["paypal_business_email"],
    payumoneyPaymentMethod: json["payumoney_payment_method"],
    payumoneyMode: json["payumoney_mode"],
    payumoneyMerchantKey: json["payumoney_merchant_key"],
    payumoneyMerchantId: json["payumoney_merchant_id"],
    payumoneySalt: json["payumoney_salt"],
    razorpayPaymentMethod: json["razorpay_payment_method"],
    razorpayKey: json["razorpay_key"],
    razorpaySecretKey: json["razorpay_secret_key"],
    paystackPaymentMethod: json["paystack_payment_method"],
    paystackPublicKey: json["paystack_public_key"],
    paystackSecretKey: json["paystack_secret_key"],
    flutterwavePaymentMethod: json["flutterwave_payment_method"],
    flutterwavePublicKey: json["flutterwave_public_key"],
    flutterwaveSecretKey: json["flutterwave_secret_key"],
    flutterwaveEncryptionKey: json["flutterwave_encryption_key"],
    flutterwaveCurrencyCode: json["flutterwave_currency_code"],
    midtransPaymentMethod: json["midtrans_payment_method"],
    isProduction: json["is_production"],
    midtransMerchantId: json["midtrans_merchant_id"],
    midtransClientKey: json["midtrans_client_key"],
    midtransServerKey: json["midtrans_server_key"],
    stripePaymentMethod: json["stripe_payment_method"],
    stripePublishableKey: json["stripe_publishable_key"],
    stripeSecretKey: json["stripe_secret_key"],
    stripeWebhookSecretKey: json["stripe_webhook_secret_key"],
    stripeCurrencyCode: json["stripe_currency_code"],
    paytmPaymentMethod: json["paytm_payment_method"],
    paytmMode: json["paytm_mode"],
    paytmMerchantKey: json["paytm_merchant_key"],
    paytmMerchantId: json["paytm_merchant_id"],
    sslMethod: json["ssl_method"],
    sslMode: json["ssl_mode"],
    sslStoreId: json["ssl_store_id"],
    sslStorePassword: json["ssl_store_password"],
    directBankTransferMethod: json["direct_bank_transfer_method"],
    accountName: json["account_name"],
    accountNumber: json["account_number"],
    bankName: json["bank_name"],
    bankCode: json["bank_code"],
    notes: json["notes"],
  );

  Map<String, dynamic> toJson() => {
    "payment_method_settings": paymentMethodSettings,
    "cod_payment_method": codPaymentMethod,
    "cod_mode": codMode,
    "paypal_payment_method": paypalPaymentMethod,
    "paypal_mode": paypalMode,
    "paypal_currency_code": paypalCurrencyCode,
    "paypal_business_email": paypalBusinessEmail,
    "payumoney_payment_method": payumoneyPaymentMethod,
    "payumoney_mode": payumoneyMode,
    "payumoney_merchant_key": payumoneyMerchantKey,
    "payumoney_merchant_id": payumoneyMerchantId,
    "payumoney_salt": payumoneySalt,
    "razorpay_payment_method": razorpayPaymentMethod,
    "razorpay_key": razorpayKey,
    "razorpay_secret_key": razorpaySecretKey,
    "paystack_payment_method": paystackPaymentMethod,
    "paystack_public_key": paystackPublicKey,
    "paystack_secret_key": paystackSecretKey,
    "flutterwave_payment_method": flutterwavePaymentMethod,
    "flutterwave_public_key": flutterwavePublicKey,
    "flutterwave_secret_key": flutterwaveSecretKey,
    "flutterwave_encryption_key": flutterwaveEncryptionKey,
    "flutterwave_currency_code": flutterwaveCurrencyCode,
    "midtrans_payment_method": midtransPaymentMethod,
    "is_production": isProduction,
    "midtrans_merchant_id": midtransMerchantId,
    "midtrans_client_key": midtransClientKey,
    "midtrans_server_key": midtransServerKey,
    "stripe_payment_method": stripePaymentMethod,
    "stripe_publishable_key": stripePublishableKey,
    "stripe_secret_key": stripeSecretKey,
    "stripe_webhook_secret_key": stripeWebhookSecretKey,
    "stripe_currency_code": stripeCurrencyCode,
    "paytm_payment_method": paytmPaymentMethod,
    "paytm_mode": paytmMode,
    "paytm_merchant_key": paytmMerchantKey,
    "paytm_merchant_id": paytmMerchantId,
    "ssl_method": sslMethod,
    "ssl_mode": sslMode,
    "ssl_store_id": sslStoreId,
    "ssl_store_password": sslStorePassword,
    "direct_bank_transfer_method": directBankTransferMethod,
    "account_name": accountName,
    "account_number": accountNumber,
    "bank_name": bankName,
    "bank_code": bankCode,
    "notes": notes,
  };
}
