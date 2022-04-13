import 'package:bima_finance/core/model/ostanding_model.dart';
import 'package:bima_finance/core/model/user_model.dart';
import 'package:flutter/material.dart';

import '../helper/nik_validator.dart';

class Api {
  //static const endpoint = "https://widiramadhan.com/bimaservices/api/";
  static const endpoint = "http://101.255.66.82/rest_api/api/";
  final timeout = 20;
  // static var nik_ktp;

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
  String getFaq = endpoint + "getfaq";
  String getJob = endpoint + "getjob";
  String getSallary = endpoint + "getsallary";
  // String getOstanding = endpoint + "getostanding?nik=$nik_ktp";
  // String updateStatusOstanding = endpoint + "updatestatusostanding";

  //credit
  String simulationCredit = endpoint + "simulationcredit";
  String applyCredit = endpoint + "applycredit";
  String getContract = endpoint + "getcontract";
  String getTenor = endpoint + "gettenor";

  String getOstanding = endpoint + "getostanding";
  // ignore: non_constant_identifier_names
  // static OstandingModel user_nik = user_nik;
      // String getOstanding = endpoint + "getostanding?user_nik=$user_nik";

 
}

// class ApiOstanding {
//   //static const endpoint = "https://widiramadhan.com/bimaservices/api/";
//   static const endpoint = "http://101.255.66.82/rest_api/api/";
//   // ignore: non_constant_identifier_names
//   static OstandingModel user_nik = OstandingModel();
//   final timeout = 20;

//       String getOstanding = endpoint + "getostanding?user_nik=$user_nik";
//       // String getOstanding = endpoint + "getostanding?nik=3276023101860002";


// }
