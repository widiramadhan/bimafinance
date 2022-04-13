// // ignore_for_file: unused_import

// import 'dart:io';

// import 'package:bima_finance/core/constant/viewstate.dart';
// import 'package:bima_finance/core/model/ostanding_model.dart';
// import 'package:bima_finance/core/model/product_model.dart';
// import 'package:bima_finance/core/repository/ostanding_repository.dart';
// import 'package:bima_finance/core/viewmodel/base_viemodel.dart';
// import 'package:bima_finance/locator.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:toast/toast.dart';

// class OstandingViewModel extends BaseViewModel {

//   OstandingRepository ostandingRepository = locator<OstandingRepository>();
  
//   // OstandingModel? ostanding;


//  Future<bool>? getOstanding(String? nik, String total, BuildContext context) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    setState(ViewState.Busy);
//    var success = await ostandingRepository.getOstanding(prefs.getString('user_id'), nik, total, context);
//    setState(ViewState.Idle);
//    if(success){
//      return true;
//    }else{
//      Toast.show(prefs.getString('message'),context,duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//      return false;
//    }
//   }
  
// }
