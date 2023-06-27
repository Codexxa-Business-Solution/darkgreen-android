import 'dart:convert';

import 'package:darkgreen/api_model/register/personal_details_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static SharedPreferences? prefs;

  static Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }

  static Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("name");
  }

  static setUserName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", name);
  }

  static Future<String?> getIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("id");
  }

  static setIds(String idss) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("id", idss);
  }

  static Future<String?> getUserNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userNumber");
  }

  static setUserNumber(String userNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userNumber", userNumber);
  }

  static Future<UserPersonalDetailsResponseModel> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return jsonDecode(prefs.getString("userData").toString());
  }

  static setUserData(String userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userData", userData);
  }

  // static Future<String?> getMasjidName() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString("masjid_name");
  // }
  //
  // static setMasjidName(String masjidName) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString("masjid_name", masjidName);
  // }
  //
  // static Future<Masjid?> getMasjid() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final masjid = Masjid.fromJson(json.decode(prefs.getString("masjid")!));
  //   print('get masjid -> $masjid');
  //   return masjid;
  // }
  //
  // static setMasjid(String masjid) async {
  //   print('set masjid -> $masjid');
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString("masjid", masjid);
  // }
  //
  // static Future<bool?> getIsFirstTime() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool("is_first");
  // }
  //
  // static Future<bool?> setIsFirstTime() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   print("IsFirstTime--> ${prefs.setBool("is_first", false)}");
  //   return prefs.setBool("is_first", false);
  // }

  static clearAppPreference() async {
    prefs = await getInstance();
    prefs?.clear();
  }
}
