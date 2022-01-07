import 'package:flutter/material.dart';

class Api {
  //static const endpoint = "https://widiramadhan.com/bimaservices/api/";
  static const endpoint = "http://101.255.66.82/rest_api/api/";
  final timeout = 20;

  //auth
  String login = endpoint + "login";
  String loginWithSSO = endpoint + "loginsso";
  String forgotPassword = endpoint + "forgotpassword";
  String resendOTP = endpoint + "resendotp";
  String verifyOTP = endpoint + "verifyotp";
  String resetPassword = endpoint + "resetpassword";
  String register = endpoint + "register";
  String activatedUser = endpoint + "activateduser";
  String changePassword = endpoint + "changepassword";

  //account
  String getUser = endpoint + "getuser";
  String updateUser = endpoint + "updateuser";
  String updateUserImages = endpoint + "changephoto";
  String deleteUserImages = endpoint + "deletephoto";
  String getAddress = endpoint + "getaddress";
  String getProvince = endpoint + "getprovince";
  String getCity = endpoint + "getcity";
  String getDistrict = endpoint + "getdistrict";
  String addAddress = endpoint + "addaddress";
  String updateAddress = endpoint + "updateaddress";
  String deleteAddress = endpoint + "deleteaddress";


  String getNotification = endpoint + "getnotification";
  String updateStatusNotification = endpoint + "updatestatusnotification";
  String getBranch = endpoint + "getbranch";
  String getNews = endpoint + "getnews";
  String getPromo = endpoint + "getpromo";
  String getProduct = endpoint + "getproduct";
  String getCareer = endpoint + "getcareer";
  String getPayment = endpoint + "getpayment";
  String getJob = endpoint + "getjob";
  String getSallary = endpoint + "getsallary";

  //credit
  String simulationCredit = endpoint + "simulationcredit";
  String applyCredit = endpoint + "applycredit";
  String getContract = endpoint + "getcontract";
}
