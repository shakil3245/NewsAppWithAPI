import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';


import '../Model/responseModel.dart';

class NetworkCaller {
  //can't create instants from other class
  NetworkCaller._();

//THIS FUCKTION WILL TAKE A URL

  static Future<ResponseModel> getRequest({required String url}) async {
    try {
      final Response response =
      await get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        // 'token': AuthController.token.toString(),
      });
      log(response.body);
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        return ResponseModel(
          isSuccess: true,
          statusCode: response.statusCode,
          returnData: jsonDecode(response.body),
        );
      } else {
        return ResponseModel(
          isSuccess: false,
          statusCode: response.statusCode,
          returnData: jsonDecode(response.body),
        );
      }
    } catch (e) {
      log(e.toString());
      return ResponseModel(
        isSuccess: false,
        statusCode: -1,
        returnData: e.toString(),
      );
    }
  }
}

