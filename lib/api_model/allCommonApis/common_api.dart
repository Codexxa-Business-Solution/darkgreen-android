import 'dart:convert';

import 'package:darkgreen/api_model/address/get_address_of_user_response_model.dart';
import 'package:darkgreen/api_model/cart/get_users_cart_response_model.dart';
import 'package:darkgreen/api_model/categories/get_product_by_cat_response_model.dart';
import 'package:darkgreen/api_model/categories/get_product_info_by_id_response_model.dart';
import 'package:darkgreen/api_model/categories/get_similar_product_response_model.dart';
import 'package:darkgreen/api_model/favorite/fav_products_response_model.dart';
import 'package:darkgreen/api_model/search/search.dart';
import 'package:http/http.dart' as http;
import 'package:darkgreen/constant/api_constant.dart';
import 'package:darkgreen/constant/share_preference.dart';
import 'package:http/http.dart';

class AllCommonApis {
  Future<GetProductsByCategoriesResponseModel> productByCategoriesApi(
      String subCatId) async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    print(subCatId);

    var response = await http.post(
        Uri.parse(
            ApiConstants().baseUrl + ApiConstants().productBySubCategories),
        body: {
          "accesskey": ApiConstants().accessKey,
          "subcategory_id": subCatId,
          "user_id": id,
          "limit": "10",
          "offset": "0",
          "sort": ""
        },
        headers: headersList);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      Map<String, dynamic> body = jsonDecode(response.body);

      print("productBySubCategoriesResponse -->  $body");

      return getProductsByCategoriesResponseModelFromJson(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<GetProductByIdResponseModel> getProductInfoByIdApi(
      String productId) async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().getProductInfoById),
        body: {
          "accesskey": ApiConstants().accessKey,
          "product_id": productId,
          "user_id": id,
        },
        headers: headersList);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      Map<String, dynamic> body = jsonDecode(response.body);

      print("getProductInfoByIdResponse -->  $body");

      return getProductByIdResponseModelFromJson(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<GetSimilarProductResponseModel> getSimilarProductByIdApi(
      String productId, String catId) async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(
            ApiConstants().baseUrl + ApiConstants().getSimilarProductById),
        body: {
          "accesskey": ApiConstants().accessKey,
          "get_similar_products": "1",
          "product_id": productId,
          "category_id": catId,
          "user_id": id,
          "limit": "1000000000000000000"
        },
        headers: headersList);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      Map<String, dynamic> body = jsonDecode(response.body);

      print("getSimilarProductResponse -->  $body");

      return getSimilarProductResponseModelFromJson(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<GetUserCartResponseModel> getAllCarts() async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().addToCart),
        body: {
          "accesskey": "90336",
          "get_user_cart": "1",
          "user_id": id,
          "offset": "0",
          "limit": "10"
        },
        headers: headersList);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      Map<String, dynamic> body = jsonDecode(response.body);

      print("getAllCartsOfUser -->  $body");
      print("getAllCartsOfUsersssss -->  ${jsonData['message']}");

      if (jsonData['message'] == "No item(s) found in user cart!") {
        // setState(() {
        //   totalCartsCount = 0;
        // });
        // totalCartsCount = 0;
      }

      return getUserCartResponseModelFromJson(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future addToCartApi(String pi, String pvi, String count) async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    try {
      final result = await http.post(
          Uri.parse(ApiConstants().baseUrl + ApiConstants().addToCart),
          body: {
            "accesskey": ApiConstants().accessKey,
            "add_to_cart": "1",
            "user_id": id,
            "product_id": pi,
            "product_variant_id": pvi,
            "qty": count
          },
          headers: headersList);

      var pdfText = await json.decode(json.encode(result.body.toString()));

      if(result.statusCode == 200){
        var data = json.decode(json.encode(result.body.toString()));
        print(data);
      }

      print("AddToCartResponse ---> ${pdfText}");

      return pdfText;
    } catch (e) {
      throw e;
    }
  }

  Future removeToCartApi(String pvi) async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    try {
      final result = await http.post(
          Uri.parse(ApiConstants().baseUrl + ApiConstants().addToCart),
          body: {
            "accesskey": ApiConstants().accessKey,
            "remove_from_cart": "1",
            "user_id": id,
            "product_variant_id": pvi
          },
          headers: headersList);

      var pdfText = await json.decode(json.encode(result.body));
      var jsonData = json.decode(result.body);
      print("removeCart ${jsonData['message']}");

      if (jsonData['message'] == "Item removed from user cart successfully") {
        print("objects");
        var result = getAllCarts();
        result.then((value) {
          // setState((){
          //   totalCartsCount = value.data.length != 0 ? value.data.length : 0;
          // });
        });
      }

      return pdfText;
    } catch (e) {
      throw e;
    }
  }

  Future removeToFavorite(String pi) async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    try {
      final result = await http.post(
          Uri.parse(ApiConstants().baseUrl + ApiConstants().addFavorite),
          body: {
            "accesskey": ApiConstants().accessKey,
            "remove_from_favorites": "1",
            "user_id": id,
            "product_id": pi,
          },
          headers: headersList);

      var pdfText = await json.decode(json.encode(result.body));

      print("Hiiiiii $pdfText");

      return pdfText;
    } catch (e) {
      throw e;
    }
  }

  Future addToFavorite(String pi) async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    try {
      final result = await http.post(
          Uri.parse(ApiConstants().baseUrl + ApiConstants().addFavorite),
          body: {
            "accesskey": ApiConstants().accessKey,
            "add_to_favorites": "1",
            "user_id": id,
            "product_id": pi,
          },
          headers: headersList);

      var pdfText = await json.decode(json.encode(result.body));

      print("Hiiiiii $pdfText");

      return pdfText;
    } catch (e) {
      throw e;
    }
  }

  Future<GetAllFavProductsResponseModel> getAllFavoriteProductsApi() async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().addFavorite),
        body: {
          "accesskey": ApiConstants().accessKey,
          "get_favorites": "1",
          "user_id": id,
          "limit": "10",
          "offset": "0",
        },
        headers: headersList);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      Map<String, dynamic> body = jsonDecode(response.body);

      print("getAllFavoriteProducts -->  $body");

      return getAllFavProductsResponseModelFromJson(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<GetSearchProductResponseModel> getAllSearchingProductsApi(
      String searchText) async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().searchProduct),
        body: {
          "accesskey": ApiConstants().accessKey,
          "type": "products-search",
          "search": searchText,
          "user_id": id,
          "offset": "0",
          "limit": "1000000",
          "sort": "id",
          "order": "ASC",
        },
        headers: headersList);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      Map<String, dynamic> body = jsonDecode(response.body);

      print("getAllSearchingProducts -->  $body");

      return getSearchProductResponseModelFromJson(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }


  Future<GetAddressOfUserResponseModel> getAddressOfUser() async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().getAddUserAddress),
        body: {
          "accesskey":"90336",
          "get_addresses":"1",
          "user_id":id,
          "offset":"0",
          "limit":"5"
        },
        headers: headersList);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      Map<String, dynamic> body = jsonDecode(response.body);

      print("getAllUsersAddress-->  $body");

      return getAddressOfUserResponseModelFromJson(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }


  Future removeAddress(String addId) async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    try {
      final result = await http.post(
          Uri.parse(ApiConstants().baseUrl + ApiConstants().getAddUserAddress),
          body: {
            "accesskey": ApiConstants().accessKey,
            "delete_address": "1",
            "id": addId
          },
          headers: headersList);

      var pdfText = await json.decode(json.encode(result.body));

      print("Hiiiiii $pdfText");

      return pdfText;
    } catch (e) {
      throw e;
    }
  }


}
