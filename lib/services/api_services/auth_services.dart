import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:screen_record_app/model/api_models/account_type_model.dart';

import '../core/api_helper.dart';
import '../core/app_urls.dart';

class AuthServices{

  Future<AccountType>login(
      String email,
      String password,
      ) async {
    // url
    String url = AppUrls.loginUrl(email, password);

    // //header
    // var header = AppHeaders.getOnlyBearerHeaders(
    //   LocalStorage.readJson(
    //     key: LocalStorageKeys.accessToken,
    //   ),
    // );

    //body
    // var data = {"email": email, "password": password};
    var response = await http.post(
      Uri.parse(url),
      // body: data,
    );
    if (kDebugMode) {
      log("Called API: $url");
      print("Status Code: ${response.statusCode}");
      // print("Sent Body: ${data.toString()}");
      print("Response Body: ${response.body}");
      // print("HEADERS: $header");
    }
    return AccountType.fromJson(ApiHelper.returnResponse(response));
  }
}