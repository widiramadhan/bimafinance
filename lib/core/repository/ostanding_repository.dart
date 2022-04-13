import 'dart:convert';
import 'dart:developer';

import 'package:bima_finance/core/constant/api.dart';
import 'package:bima_finance/core/helper/dio_exception.dart';
import 'package:bima_finance/core/model/ostanding_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


class OstandingRepository extends ChangeNotifier {
  Response? response;
  Dio dio = new Dio();

/*
  Future<OstandingModel?> getOstanding(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio.post(Api().getOstanding,
          options: Options(headers: {"Accept": "application/json",}),
          data: FormData.fromMap({
            'user_nik': ('user_nik'),
            'total' : ('total'),
          })).timeout(Duration (seconds: Api().timeout));
      if (response!.data['isSuccess'] == true) {
        notifyListeners();
       final Map<String, dynamic> parsed = response?.data['data'];
        final dataOstanding = OstandingModel.fromJson(parsed);
        return dataOstanding;
      } else {
        prefs.setString('message', prefs.getString('message')!);
        return null;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      prefs.setString('message', errorMessage);
      Toast.show(errorMessage, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return null;
    }
  }
  */

  Future<bool> getOstanding(String? userId, String? nik, String? total, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try{
   response = await dio.post(Api().getOstanding,
          options: Options(headers: {
            "Accept": "application/json",
            "Authorization": "Bearer "+prefs.getString('token')!}),
          data: FormData.fromMap({
            'user_id': userId,
            'nik': nik,
            'total': total,
            
          })).timeout(Duration (seconds: Api().timeout));
      if (response?.data['isSuccess'] == true) {
        prefs.setString('message', response?.data['message']);
        return true;
      } else {
        prefs.setString('message', response?.data['message']);
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      prefs.setString('message', errorMessage);
      return false;
    }
  }
  


  // Future<OstandingModel?> getOstanding(BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   try {
  //     response = await dio.get(
  //       Api().getOstanding,
  //       options: Options(headers: {}),).timeout(Duration (seconds: Api().timeout));
  //     if (response!.statusCode == 200) {
  //       if (response!.data['isSuccess'] == true) {
  //         notifyListeners();
  //        final Map<String, dynamic> parsed = response?.data['data'];
  //       final dataOstanding = OstandingModel.fromJson(parsed);
  //       return dataOstanding;
  //       } else {
  //         prefs.setString('message', prefs.getString('message')!);
  //         return null;
  //       }
  //     } else {
  //       prefs.setString('message', prefs.getString('message')!);
  //       return null;
  //     }
  //   }  on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     prefs.setString('message', errorMessage);
  //     Toast.show(errorMessage, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //     return null;
  //   }
  // }
}


