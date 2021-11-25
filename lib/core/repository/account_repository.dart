import 'dart:async';
import 'dart:io';

import 'package:bima_finance/core/constant/api.dart';
import 'package:bima_finance/core/helper/dio_exception.dart';
import 'package:bima_finance/core/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class AccountRepository extends ChangeNotifier {
  Response? response;
  Dio dio = new Dio();

  Future sessionExpired (BuildContext context) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove('is_login');
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => LoginView(),
    //   ),
    // ).then((value) {
    //   AccountViewModel().checkSessionLogin();
    // });
  }


  Future<UserModel?> getUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    try {
      response = await dio.post(Api().getUser,
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": "Bearer "+token
        }),
        data: FormData.fromMap({
          'user_id': prefs.getString('user_id')
        })).timeout(Duration (seconds: Api().timeout)
      );
      if (response?.data['isSuccess'] == true) {
        notifyListeners();
        final Map<String, dynamic> parsed = response?.data['data'];
        final dataProfile = UserModel.fromJson(parsed);
        return dataProfile;
      } else {
        Toast.show(response?.data['message'], context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        return null;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      prefs.setString('message', errorMessage);
      if(e.response?.statusCode == 401){
        sessionExpired(context);
      } else {
        Toast.show(errorMessage, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
      return null;
    }
  }

  Future<bool> updateUser(String strFullName, String strPhoneNumber, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    try {
      response = await dio.post(Api().updateUser,
          options: Options(headers: {"Accept": "application/json", "Authorization": "Bearer "+token}),
          data: FormData.fromMap({
            'user_id': prefs.getString('user_id'),
            'fullname': strFullName,
            'phone_number': strPhoneNumber
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
      Toast.show(errorMessage, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      if(e.response?.statusCode == 401){
        sessionExpired(context);
      }
      return false;
    }
  }

  Future<bool> deleteUserImages(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio.post(Api().deleteUserImages,
          options: Options(headers: {"Accept": "application/json", "Authorization": "Bearer "+prefs.getString('token')!}),
          data: FormData.fromMap({
            'user_id': prefs.getString('user_id')
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
      Toast.show(errorMessage, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      if(e.response?.statusCode == 401){
        sessionExpired(context);
      }
      return false;
    }
  }

  Future<bool> updateUserImages(File file, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fileName = file.path.split('/').last;
    try {
      response = await dio.post(Api().updateUserImages,
          options: Options(headers: {
            "Accept": "application/json",
            "Authorization": "Bearer "+prefs.getString('token')!}),
          data: FormData.fromMap({
            'user_id': prefs.getString('user_id'),
            'profile_picture': await MultipartFile.fromFile(
              file.path,
              filename: fileName,
            ),
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
      Toast.show(errorMessage, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      if(e.response?.statusCode == 401){
        sessionExpired(context);
      }
      return false;
    }
  }
}
