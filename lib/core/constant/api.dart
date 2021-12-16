import 'package:flutter/material.dart';

class Api {
  //static const endpoint = "https://widiramadhan.com/bimaservices/api/";
  static const endpoint = "http://192.168.1.2/bimaservices/api/";
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


  String getSlider = endpoint + "slider/getSlider";
  String getBranch = endpoint + "branch/getBranch";
  String getNews = endpoint + "news/getNews";
  String getPromo = endpoint + "promo/getPromo";
  String getProduct = endpoint + "product/getProduct";
  String getCareer = endpoint + "career/getCareer";
  String getPayment = endpoint + "payment/getPayment";
  String getJob = endpoint + "master/getJob";
  String getSallary = endpoint + "master/getSallary";

  //credit
  String simulationCredit = endpoint + "credit/simulationCredit";
  String applyCredit = endpoint + "credit/applyCredit";
}
