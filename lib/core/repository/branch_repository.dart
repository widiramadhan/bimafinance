import 'dart:convert';
import 'dart:developer';

import 'package:bima_finance/core/constant/api.dart';
import 'package:bima_finance/core/helper/dio_exception.dart';
import 'package:bima_finance/core/model/branch_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class BranchRepository extends ChangeNotifier {
  Response? response;
  Dio dio = new Dio();

  Future<List<BranchModel>?> getBranch(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio.get(
        Api().getBranch,
        options: Options(headers: {}),).timeout(Duration (seconds: Api().timeout));
      if (response!.statusCode == 200) {
        if (response!.data['isSuccess'] == true) {
          notifyListeners();
          Iterable data = response!.data['data'];
          List<BranchModel> listData = data.map((map) => BranchModel.fromJson(map)).toList();
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
