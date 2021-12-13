import 'dart:async';

import 'package:bima_finance/core/constant/api.dart';
import 'package:bima_finance/core/helper/dio_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository extends ChangeNotifier {
  Response? response;
  Dio dio = new Dio();

  Future<bool> checkLogin(String strEmail, String strPassword, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio.post(Api().login,
          options: Options(headers: {"Accept": "application/json",}),
          data: FormData.fromMap({
            'email': strEmail,
            'fcm_token': prefs.getString('fcm'),
            'password': strPassword
          })).timeout(Duration (seconds: Api().timeout));
      if (response?.data['isSuccess'] == true) {
        //if(response?.data['data']['is_active'] == 1) {
          prefs.setBool('is_login', true);
          prefs.setString('user_id', response!.data['data']['user_id'].toString());
          prefs.setString('name', response?.data['data']['fullname']);
          prefs.setString('phone', response?.data['data']['phone']);
          prefs.setString('email', response?.data['data']['email']);
          prefs.setString('token', response?.data['data']['token']);
          prefs.setString('message', response?.data['message']);
          return true;
        // }else{
        //   Toast.show(response?.data['message'], context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        //   Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => OtpView(email: strEmail, type: OtpType.Register,)),
        //   );
        // }
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

  Future<bool> loginWithSSO(String strFullname, String strEmail, strPhoneNumber, String profilePicture, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio.post(Api().loginWithSSO,
          options: Options(headers: {"Accept": "application/json",}),
          data: FormData.fromMap({
            'email': strEmail,
            'fullname': strFullname,
            'phone_number': strPhoneNumber,
            'fcm_token': prefs.getString('fcm')
          })).timeout(Duration (seconds: Api().timeout));
      if (response?.data['isSuccess'] == true) {
        prefs.setBool('is_login', true);
        prefs.setString('user_id', response!.data['data']['user_id'].toString());
        prefs.setString('email', response?.data['data']['email']);
        prefs.setString('token', response?.data['data']['token']);
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

  Future<bool> forgotPassword(String strEmail, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio.post(Api().forgotPassword,
          options: Options(headers: {"Accept": "application/json",}),
          data: FormData.fromMap({
            'email': strEmail
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

  Future<bool> resendOTP(String strEmail, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio.post(Api().resendOTP,
          options: Options(headers: {"Accept": "application/json",}),
          data: FormData.fromMap({
            'email': strEmail
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

  Future<bool> verifyOTP(String strEmail, String strOtp, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio.post(Api().verifyOTP,
          options: Options(headers: {"Accept": "application/json",}),
          data: FormData.fromMap({
            'email': strEmail,
            'otp': strOtp
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

  Future<bool> resetPassword(String strEmail, String strPassword, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio.post(Api().resetPassword,
          options: Options(headers: {"Accept": "application/json",}),
          data: FormData.fromMap({
            'email': strEmail,
            'password': strPassword
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

  Future<bool> changePassword(String strOldPassword, String strNewPassword, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio.post(Api().changePassword,
          options: Options(headers: {"Accept": "application/json",}),
          data: FormData.fromMap({
            'user_id': prefs.getString('user_id'),
            'old_password': strOldPassword,
            'new_password': strNewPassword
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

  Future<bool> register(String strFullname, String strEmail, String strPhoneNumber, String strPassword, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio.post(Api().register,
          options: Options(headers: {"Accept": "application/json",}),
          data: FormData.fromMap({
            'fullname': strFullname,
            'email': strEmail,
            'phone_number': strPhoneNumber,
            'password': strPassword
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

  Future<bool> activeatedAccount(String strEmail, String strOtp, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio.post(Api().activatedUser,
          options: Options(headers: {"Accept": "application/json",}),
          data: FormData.fromMap({
            'email': strEmail,
            'otp': strOtp
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
}
