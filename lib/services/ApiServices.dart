import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../model/verifyOtpModel.dart';

class ApiService {
  final _host = 'apicherry-v3.redcarpetup.com';
  var _customerNo;

  Future<void> sendOtp(String mobileNo,) async {
    _customerNo = mobileNo;
    print('second one $_customerNo');
     await request(
        path: 'user_mobile_signup', parameters: {'mobile': '$mobileNo'},postRequest: false);
   
  }

  Future<String> verifyOtp({
    String code,
    String mobileNo,
  }) async {
    final result = await request(path: 'user_mobile_verify', parameters: {
      'mobile': '$mobileNo',
      'code': '$code',
      'resource_id': ''
    },postRequest: false);
    print(result);
    print('verify otp method response result["result"]');
    VerifyOtpModel verifyOtp = VerifyOtpModel.fromJson(result);
    return verifyOtp.result;
  }

  Future<String> permissiongranted() async {
    final result = await request(path: 'user_permissions_accepted',postRequest: true);
    print('result');
    return result["result"];
  }

  Future<Map> request(
      {@required String path, Map<String, String> parameters,bool postRequest}) async {
    final uri = Uri.https(_host, '$path', parameters);
    print(uri);
    final results = postRequest ? await http.post(
      uri,headers: _headers
    ) : await http.get(
      uri,headers: _headers
    );
    
    print('status code is ${results.statusCode}');
    print(results.body.toString());
    final jsonObject = json.decode(results.body.toString());
    print('json object $jsonObject');
    return jsonObject;
  }

Map<String, String> get _headers =>
      {'mobile': '$_customerNo', };
}
