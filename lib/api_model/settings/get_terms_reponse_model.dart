// To parse this JSON data, do
//
//     final getTermsResponseModel = getTermsResponseModelFromJson(jsonString);

import 'dart:convert';

GetTermsResponseModel getTermsResponseModelFromJson(String str) => GetTermsResponseModel.fromJson(json.decode(str));

String getTermsResponseModelToJson(GetTermsResponseModel data) => json.encode(data.toJson());

class GetTermsResponseModel {
  bool error;
  String terms;

  GetTermsResponseModel({
    required this.error,
    required this.terms,
  });

  factory GetTermsResponseModel.fromJson(Map<String, dynamic> json) => GetTermsResponseModel(
    error: json["error"],
    terms: json["terms"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "terms": terms,
  };
}
