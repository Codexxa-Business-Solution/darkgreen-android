import 'dart:convert';

GetAddressOfUserResponseModel getAddressOfUserResponseModelFromJson(
        String str) =>
    GetAddressOfUserResponseModel.fromJson(json.decode(str));

String getAddressOfUserResponseModelToJson(
        GetAddressOfUserResponseModel data) =>
    json.encode(data.toJson());

class GetAddressOfUserResponseModel {
  bool? error;
  String? total;
  List<Data>? data;

  GetAddressOfUserResponseModel({this.error, this.total, this.data});

  GetAddressOfUserResponseModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    total = json['total'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['total'] = total;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? userId;
  String? type;
  String? name;
  String? countryCode;
  String? mobile;
  String? alternateMobile;
  String? address;
  String? landmark;
  String? areaId;
  String? cityId;
  String? pincode;
  String? state;
  String? country;
  String? latitude;
  String? longitude;
  String? isDefault;
  String? dateCreated;
  String? cityName;
  String? areaName;
  String? minimumFreeDeliveryOrderAmount;
  String? minimumOrderAmount;
  String? deliveryCharges;

  Data(
      {this.id,
      this.userId,
      this.type,
      this.name,
      this.countryCode,
      this.mobile,
      this.alternateMobile,
      this.address,
      this.landmark,
      this.areaId,
      this.cityId,
      this.pincode,
      this.state,
      this.country,
      this.latitude,
      this.longitude,
      this.isDefault,
      this.dateCreated,
      this.cityName,
      this.areaName,
      this.minimumFreeDeliveryOrderAmount,
      this.minimumOrderAmount,
      this.deliveryCharges});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    name = json['name'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    alternateMobile = json['alternate_mobile'];
    address = json['address'];
    landmark = json['landmark'];
    areaId = json['area_id'];
    cityId = json['city_id'];
    pincode = json['pincode'];
    state = json['state'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isDefault = json['is_default'];
    dateCreated = json['date_created'];
    cityName = json['city_name'];
    areaName = json['area_name'];
    minimumFreeDeliveryOrderAmount = json['minimum_free_delivery_order_amount'];
    minimumOrderAmount = json['minimum_order_amount'];
    deliveryCharges = json['delivery_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['type'] = type;
    data['name'] = name;
    data['country_code'] = countryCode;
    data['mobile'] = mobile;
    data['alternate_mobile'] = alternateMobile;
    data['address'] = address;
    data['landmark'] = landmark;
    data['area_id'] = areaId;
    data['city_id'] = cityId;
    data['pincode'] = pincode;
    data['state'] = state;
    data['country'] = country;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['is_default'] = isDefault;
    data['date_created'] = dateCreated;
    data['city_name'] = cityName;
    data['area_name'] = areaName;
    data['minimum_free_delivery_order_amount'] = minimumFreeDeliveryOrderAmount;
    data['minimum_order_amount'] = minimumOrderAmount;
    data['delivery_charges'] = deliveryCharges;
    return data;
  }
}
