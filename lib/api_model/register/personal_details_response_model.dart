// To parse this JSON data, do
//
//     final userPersonalDetailsResponseModel = userPersonalDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

UserPersonalDetailsResponseModel userPersonalDetailsResponseModelFromJson(String str) => UserPersonalDetailsResponseModel.fromJson(json.decode(str));

String userPersonalDetailsResponseModelToJson(UserPersonalDetailsResponseModel data) => json.encode(data.toJson());

class UserPersonalDetailsResponseModel {
  UserPersonalDetailsResponseModel({
    required this.error,
    required this.message,
    required this.password,
    required this.userId,
    required this.name,
    required this.email,
    required this.profile,
    required this.mobile,
    required this.countryCode,
    required this.dob,
    required this.balance,
    required this.cityId,
    required this.cityName,
    required this.areaId,
    required this.areaName,
    required this.street,
    required this.pincode,
    required this.referralCode,
    required this.friendsCode,
    required this.latitude,
    required this.longitude,
    required this.apikey,
    required this.status,
    required this.createdAt,
  });

  bool error;
  String message;
  String password;
  String userId;
  String name;
  String email;
  String profile;
  String mobile;
  String countryCode;
  String dob;
  String balance;
  String cityId;
  String cityName;
  String areaId;
  String areaName;
  String street;
  String pincode;
  String referralCode;
  String friendsCode;
  String latitude;
  String longitude;
  String apikey;
  String status;
  DateTime createdAt;

  factory UserPersonalDetailsResponseModel.fromJson(Map<String, dynamic> json) => UserPersonalDetailsResponseModel(
    error: json["error"],
    message: json["message"],
    password: json["password"],
    userId: json["user_id"],
    name: json["name"],
    email: json["email"],
    profile: json["profile"],
    mobile: json["mobile"],
    countryCode: json["country_code"],
    dob: json["dob"],
    balance: json["balance"],
    cityId: json["city_id"],
    cityName: json["city_name"],
    areaId: json["area_id"],
    areaName: json["area_name"],
    street: json["street"],
    pincode: json["pincode"],
    referralCode: json["referral_code"],
    friendsCode: json["friends_code"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    apikey: json["apikey"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "password": password,
    "user_id": userId,
    "name": name,
    "email": email,
    "profile": profile,
    "mobile": mobile,
    "country_code": countryCode,
    "dob": dob,
    "balance": balance,
    "city_id": cityId,
    "city_name": cityName,
    "area_id": areaId,
    "area_name": areaName,
    "street": street,
    "pincode": pincode,
    "referral_code": referralCode,
    "friends_code": friendsCode,
    "latitude": latitude,
    "longitude": longitude,
    "apikey": apikey,
    "status": status,
    "created_at": createdAt.toIso8601String(),
  };
}
