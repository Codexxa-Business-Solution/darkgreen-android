import 'dart:convert';

import 'package:darkgreen/allCommonApis/constants.dart';
import 'package:darkgreen/api_model/login/register_device_response.dart';
import 'package:http/http.dart' as http;

class ApiImplementation {
  // register device
  Future<RegisterDeviceResponse> registerDevice() async {
    // url
    final url = Uri.parse(Constants.registerDeviceEndpoint);

    // headers
    final headers = {
      'Authorization': 'Bearer ${Constants.token}',
    };

    //body
    final body = {
      'accesskey': Constants.accessKey,
      'user_id': '500',
      'token': '227',
    };

    // response
    final response = await http.post(url, headers: headers, body: body);

    // parse response
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return RegisterDeviceResponse.fromJson(json);
    } else {
      throw Exception('Failed to register device');
    }
  }
}
