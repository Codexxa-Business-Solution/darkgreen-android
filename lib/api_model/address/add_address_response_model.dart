class AddAddressReponseModel {
  AddAddressReponseModel({
      this.error, 
      this.message, 
      this.id, 
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
      this.minimumFreeDeliveryOrderAmount, 
      this.minimumOrderAmount, 
      this.cityName, 
      this.areaName, 
      this.deliveryCharges,});

  AddAddressReponseModel.fromJson(dynamic json) {
    error = json['error'];
    message = json['message'];
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
    minimumFreeDeliveryOrderAmount = json['minimum_free_delivery_order_amount'];
    minimumOrderAmount = json['minimum_order_amount'];
    cityName = json['city_name'];
    areaName = json['area_name'];
    deliveryCharges = json['delivery_charges'];
  }
  bool? error;
  String? message;
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
  String? minimumFreeDeliveryOrderAmount;
  String? minimumOrderAmount;
  String? cityName;
  String? areaName;
  String? deliveryCharges;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['message'] = message;
    map['id'] = id;
    map['user_id'] = userId;
    map['type'] = type;
    map['name'] = name;
    map['country_code'] = countryCode;
    map['mobile'] = mobile;
    map['alternate_mobile'] = alternateMobile;
    map['address'] = address;
    map['landmark'] = landmark;
    map['area_id'] = areaId;
    map['city_id'] = cityId;
    map['pincode'] = pincode;
    map['state'] = state;
    map['country'] = country;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['is_default'] = isDefault;
    map['minimum_free_delivery_order_amount'] = minimumFreeDeliveryOrderAmount;
    map['minimum_order_amount'] = minimumOrderAmount;
    map['city_name'] = cityName;
    map['area_name'] = areaName;
    map['delivery_charges'] = deliveryCharges;
    return map;
  }

}