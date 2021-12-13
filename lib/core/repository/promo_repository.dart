import 'dart:convert';
import 'dart:developer';

import 'package:bima_finance/core/constant/api.dart';
import 'package:bima_finance/core/helper/dio_exception.dart';
import 'package:bima_finance/core/model/promo_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class PromoRepository extends ChangeNotifier {
  Response? response;
  Dio dio = new Dio();

  Future<List<PromoModel>?> getPromo(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio.get(
        Api().getPromo,
        options: Options(headers: {}),).timeout(Duration (seconds: Api().timeout));
      if (response!.statusCode == 200) {
        if (response!.data['isSuccess'] == true) {
          notifyListeners();
          Iterable data = response!.data['data'];
          List<PromoModel> listData = data.map((map) => PromoModel.fromJson(map)).toList();
          return listData;
        } else {
          prefs.setString('message', prefs.getString('message')!);
          return null;
        }
      } else {
        prefs.setString('message', prefs.getString('message')!);
        return null;
      }
    }  on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      prefs.setString('message', errorMessage);
      Toast.show(errorMessage, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return null;
    }
  }
}
