import 'dart:developer';

import 'package:get/get.dart';
import 'package:news_app_api/Model/everyNewsModel.dart';

import '../network/netwrokCaller.dart';
class EveryNewsController extends GetxController{
  bool _getEveryNewsInProgress = false;
  bool get getEveryNewsInProgress => _getEveryNewsInProgress;

  EveryNewsModel _everyNewsModel = EveryNewsModel();
  EveryNewsModel get everyNewsModel => _everyNewsModel;

  Future<bool> getEveryNewsData() async {
    _getEveryNewsInProgress = true;
    update();
    final response = await NetworkCaller.getRequest(url: "https://newsapi.org/v2/everything?q=bitcoin&apiKey=0479d1534b384ac98e4575e399508861");
    log(response.toString());
    _getEveryNewsInProgress = false;
    if (response.isSuccess) {
      _everyNewsModel = EveryNewsModel.fromJson(response.returnData);
      update();
      return true;
    } else {
      update();
      return true;
    }
  }
}