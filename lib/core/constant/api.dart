import 'package:flutter/material.dart';

class Api {
  static const endpoint = "https://widiramadhan.com/bimaservices/api/";
  //static const endpoint = "http://192.168.1.6/taniqu/api/";
  final timeout = 20;

  //auth
  String login = endpoint + "auth/login";
  String loginWithSSO = endpoint + "auth/loginWithSSO";
  String forgotPassword = endpoint + "auth/forgotPassword";
  String resendOTP = endpoint + "auth/resendOTP";
  String verifyOTP = endpoint + "auth/verifyOTP";
  String resetPassword = endpoint + "auth/resetPassword";
  String register = endpoint + "auth/register";
  String activatedUser = endpoint + "auth/activatedUser";
  String changePassword = endpoint + "auth/changePassword";

  //account
  String getUser = endpoint + "user/getUser";
  String updateUser = endpoint + "user/updateUser";
  String updateUserImages = endpoint + "user/changePhoto";
  String deleteUserImages = endpoint + "user/deletePhoto";
  String getAddress = endpoint + "user/getAddress";
  String getProvince = endpoint + "user/getProvince";
  String getCity = endpoint + "user/getCity";
  String getDistrict = endpoint + "user/getDistrict";
  String addAddress = endpoint + "user/addAddress";
  String updateAddress = endpoint + "user/updateAddress";
  String deleteAddress = endpoint + "user/deleteAddress";

  //slider
  String getSlider = endpoint + "slider/getSlider";
}
