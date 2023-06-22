import 'dart:convert';
import 'dart:developer';

import 'package:darkgreen/api_model/address/get_address_of_user_response_model.dart';
import 'package:darkgreen/api_model/cart/delete_save_for_later_response_model.dart';
import 'package:darkgreen/api_model/cart/get_save_for_later_response_model.dart';
import 'package:darkgreen/api_model/cart/get_users_cart_response_model.dart';
import 'package:darkgreen/api_model/cart/save_for_later_response_model.dart';
import 'package:darkgreen/api_model/categories/get_product_by_cat_response_model.dart';
import 'package:darkgreen/api_model/categories/get_product_info_by_id_response_model.dart';
import 'package:darkgreen/api_model/categories/get_similar_product_response_model.dart';
import 'package:darkgreen/api_model/favorite/fav_products_response_model.dart';
import 'package:darkgreen/api_model/login/change_pasword_response_model.dart';
import 'package:darkgreen/api_model/order/get_all_orders_status_response_model.dart';
import 'package:darkgreen/api_model/order/get_order_delete_resonse_model.dart';
import 'package:darkgreen/api_model/order/get_promo_code_response_model.dart';
import 'package:darkgreen/api_model/order/get_promo_code_valid_response_model.dart';
import 'package:darkgreen/api_model/search/search.dart';
import 'package:darkgreen/api_model/settings/blog_categories_response_model.dart';
import 'package:darkgreen/api_model/settings/get_all_payment_method_response.dart';
import 'package:darkgreen/api_model/wallet/get_wallet_history_response_model.dart';
import 'package:darkgreen/constant/api_constant.dart';
import 'package:darkgreen/constant/share_preference.dart';
import 'package:darkgreen/utils.dart';
import 'package:http/http.dart' as http;

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

      Map<String, dynamic> body = jsonDecode(response.body.jsonBody());

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

      return getProductByIdResponseModelFromJson(response.body.jsonBody());
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

      return getSimilarProductResponseModelFromJson(response.body.jsonBody());
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
      var jsonData = json.decode(response.body.jsonBody());

      Map<String, dynamic> body = jsonDecode(response.body.jsonBody());

      print("getAllCartsOfUser -->  $body");
      print("getAllCartsOfUsersssss -->  ${jsonData['message']}");

      if (jsonData['message'] == "No item(s) found in user cart!") {
        // setState(() {
        //   totalCartsCount = 0;
        // });
        // totalCartsCount = 0;
      }

      return getUserCartResponseModelFromJson(response.body.jsonBody());
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

      if (result.statusCode == 200) {
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

      return getAllFavProductsResponseModelFromJson(response.body.jsonBody());
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

      return getSearchProductResponseModelFromJson(response.body.jsonBody());
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
          "accesskey": "90336",
          "get_addresses": "1",
          "user_id": id,
          "offset": "0",
          "limit": "5"
        },
        headers: headersList);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      Map<String, dynamic> body = jsonDecode(response.body);

      print("getAllUsersAddress-->  $body");

      return getAddressOfUserResponseModelFromJson(response.body.jsonBody());
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

  Future<GetAddSaveForLaterResponseModel> addSaveForLater(String pvi) async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().addToCart),
        body: {
          "accesskey": ApiConstants().accessKey,
          "add_save_for_later": "1",
          "user_id": id,
          "product_variant_id": pvi
        },
        headers: headersList);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      Map<String, dynamic> body = jsonDecode(response.body);

      print("getAddSaveForLaterResponse -->  $body");

      return getAddSaveForLaterResponseModelFromJson(response.body.jsonBody());
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<GetSaveForLaterResponseModel> getSaveForLater() async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().addToCart),
        body: {
          "accesskey": ApiConstants().accessKey,
          "get_save_for_later": "1",
          "user_id": id,
        },
        headers: headersList);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      Map<String, dynamic> body = jsonDecode(response.body);

      print("getAddSaveForLaterResponse -->  $body");

      return getSaveForLaterResponseModelFromJson(response.body.jsonBody());
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<DeleteSaveForLaterResponseModel> deleteSaveForLater(String pvi) async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().addToCart),
        body: {
          "accesskey": ApiConstants().accessKey,
          "remove_save_for_later": "1",
          "user_id": id,
          "product_variant_id": pvi
        },
        headers: headersList);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      Map<String, dynamic> body = jsonDecode(response.body);

      print("getAddSaveForLaterResponse -->  $body");

      return deleteSaveForLaterResponseModelFromJson(response.body.jsonBody());
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<GetWalletHistoryResponseModel> getWalletHistory() async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().getUserWallet),
        body: {
          "accesskey": ApiConstants().accessKey,
          "get_user_transactions": "1",
          "user_id": id,
          "type": "wallet_transactions",
          "offset": "0",
          "limit": "0"
        },
        headers: headersList);

    log(response.body);

    if (response.statusCode == 200) {
      // Map<String, dynamic> body = jsonDecode(response.body);
      //
      // print("getWalletHistory -->  $body");

      return getWalletHistoryResponseModelFromJson(response.body.jsonBody());
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<GetPromoCodeResponseModel> getPromoCode(String amount) async {
    print(amount);
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().getAllPromoCodes),
        body: {
          "accesskey": ApiConstants().accessKey,
          "get_promo_codes": "1",
          "user_id": id,
          "type": "wallet_transactions",
          "offset": "0",
          "limit": "5",
          "sort": "",
          "amount": "10"
        },
        headers: headersList);

    log(response.body);

    if (response.statusCode == 200) {
      // Map<String, dynamic> body = jsonDecode(response.body);
      //
      // print("getPromoCode -->  $body");

      return getPromoCodeResponseModelFromJson(response.body.jsonBody());
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<GetPromoCodeValidResponseModel> getPromoCodeValid(
      String amount, String promoCode) async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().getAllPromoCodes),
        body: {
          "accesskey": ApiConstants().accessKey,
          "validate_promo_code": "1",
          "user_id": id,
          "promo_code": promoCode,
          "total": amount
        },
        headers: headersList);

    log(response.body);

    if (response.statusCode == 200) {
      print("getPromoCodeValid -->  ${response.body.jsonBody()}");

      return getPromoCodeValidResponseModelFromJson(response.body.jsonBody());
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<GetOredersStatusResponseModel> getAllOrdersStatus() async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().getAllOrdersStatus),
        body: {
          "accesskey": ApiConstants().accessKey,
          "get_orders": "1",
          "user_id": id,
        },
        headers: headersList);

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      print("getAllOrderStatus -->  $body");

      return getOrdersStatusResponseModelFromJson(response.body.jsonBody());
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<GetPaymentMethodResponseModel> getAllPaymentMethodShow() async {
    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().getSettingsData),
        body: {
          "accesskey": ApiConstants().accessKey,
          "settings": "1",
          "get_payment_methods": "1"
        },
        headers: headersList);

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      print("getAllPaymentMethodShow -->  $body");

      return getPaymentMethodResponseModelFromJson(response.body.jsonBody());
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<GetOrderDeleteResponseModel> getOrderDelete(String orderId) async {
    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().getAllOrdersStatus),
        body: {
          "accesskey": ApiConstants().accessKey,
          "delete_order": "1",
          "order_id": orderId
        },
        headers: headersList);

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      print("getAllPaymentMethodShow -->  $body");

      return getOrderDeleteResponseModelFromJson(response.body.jsonBody());
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<String> getInvoiceOrder(String orderId) async {
    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().getAllOrdersStatus),
        body: {
          "accesskey": ApiConstants().accessKey,
          "get_order_invoice": "1",
          "order_id": orderId
        },
        headers: headersList);

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      print("getAllPaymentMethodShow -->  $body");

      return response.body.jsonBody();
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<GetOredersStatusResponseModel> getAllRecieverStatus() async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().getAllOrdersStatus),
        body: {
          "accesskey": ApiConstants().accessKey,
          "get_orders": "1",
          "user_id": id,
          "status": "received"
        },
        headers: headersList);

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      print("getAllRecievedStatus -->  $body");

      return getOrdersStatusResponseModelFromJson(response.body.jsonBody());
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<GetOredersStatusResponseModel> getAllProcessedStatus() async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().getAllOrdersStatus),
        body: {
          "accesskey": ApiConstants().accessKey,
          "get_orders": "1",
          "user_id": id,
          "status": "processed"
        },
        headers: headersList);

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      print("getAllProcessedStatus -->  $body");

      return getOrdersStatusResponseModelFromJson(response.body.jsonBody());
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<GetOredersStatusResponseModel> getAllShippedStatus() async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().getAllOrdersStatus),
        body: {
          "accesskey": ApiConstants().accessKey,
          "get_orders": "1",
          "user_id": id,
          "status": "shipped"
        },
        headers: headersList);

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      print("getAllShippedStatus -->  $body");

      return getOrdersStatusResponseModelFromJson(response.body.jsonBody());
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<GetOredersStatusResponseModel> getAllDeliveredStatus() async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().getAllOrdersStatus),
        body: {
          "accesskey": ApiConstants().accessKey,
          "get_orders": "1",
          "user_id": id,
          "status": "delivered"
        },
        headers: headersList);

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      print("getAllDeliveredStatus -->  $body");

      return getOrdersStatusResponseModelFromJson(response.body.jsonBody());
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<GetOredersStatusResponseModel> getAllCancelledStatus() async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().getAllOrdersStatus),
        body: {
          "accesskey": ApiConstants().accessKey,
          "get_orders": "1",
          "user_id": id,
          "status": "cancelled"
        },
        headers: headersList);

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      print("getAllCancelledStatus -->  $body");

      return getOrdersStatusResponseModelFromJson(response.body.jsonBody());
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<GetOredersStatusResponseModel> getAllReturnedStatus() async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().getAllOrdersStatus),
        body: {
          "accesskey": ApiConstants().accessKey,
          "get_orders": "1",
          "user_id": id,
          "status": "returned"
        },
        headers: headersList);

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      print("getAllReturnedStatus -->  $body");

      return getOrdersStatusResponseModelFromJson(response.body.jsonBody());
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<GetOredersStatusResponseModel> getAllPickUpStatus() async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().getAllOrdersStatus),
        body: {
          "accesskey": ApiConstants().accessKey,
          "get_orders": "1",
          "user_id": id,
          "status": "ready_to_pickup"
        },
        headers: headersList);

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      print("getAllReturnedStatus -->  $body");

      return getOrdersStatusResponseModelFromJson(response.body.jsonBody());
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<GetWalletHistoryResponseModel> getTransactionHistory() async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().getUserWallet),
        body: {
          "accesskey": ApiConstants().accessKey,
          "get_user_transactions": "1",
          "user_id": id,
          "type": "transactions",
          "offset": "0",
          "limit": "0"
        },
        headers: headersList);

    log(response.body);

    if (response.statusCode == 200) {
      // Map<String, dynamic> body = jsonDecode(response.body);
      //
      // print("getWalletHistory -->  $body");

      return getWalletHistoryResponseModelFromJson(response.body.jsonBody());
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<ChangePasswordResponseModel> getChangePassword(String password) async {
    String? id = await AppPreferences.getIds();

    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().usersRegister),
        body: {
          "accesskey": ApiConstants().accessKey,
          "type": "change-password",
          "id": id,
          "password": password,
        },
        headers: headersList);

    log(response.body);

    if (response.statusCode == 200) {
      // Map<String, dynamic> body = jsonDecode(response.body);
      //
      // print("getWalletHistory -->  $body");

      return changePasswordResponseModelFromJson(response.body.jsonBody());
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<GetBlogCatergoriesResponseModel> getBlogCategoriesApi() async {
    var headersList = {'Authorization': 'Bearer ${ApiConstants().token}'};

    var response = await http.post(
        Uri.parse(ApiConstants().baseUrl + ApiConstants().getBlogsData),
        body: {
          "accesskey": ApiConstants().accessKey,
          "get_blog_categories": "1",
        },
        headers: headersList);

    log(response.body);

    if (response.statusCode == 200) {
      return getBlogCatergoriesResponseModelFromJson(response.body.jsonBody());
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
