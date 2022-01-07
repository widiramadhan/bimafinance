import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/model/user_model.dart';
import 'package:bima_finance/core/repository/account_repository.dart';
import 'package:bima_finance/core/viewmodel/base_viemodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../../locator.dart';

class AccountViewModel extends BaseViewModel {
  AccountRepository accountRepository = locator<AccountRepository>();
  UserModel? user;

  bool isLogin = false;
  bool hidePass = true;
  bool hidePass2 = true;

  void changeHidePass() {
    hidePass = !hidePass;
    notifyListeners();
  }

  void changeHidePass2() {
    hidePass = !hidePass;
    notifyListeners();
  }

  Future<String?> checkSessionLogin() async {
    setState(ViewState.Busy);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool('is_login') ?? false;
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future getUser(BuildContext context) async {
    setState(ViewState.Busy);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user = await accountRepository.getUser(context);
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future<bool> updateProfile(String name, String phone, BuildContext context) async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var success = await accountRepository.updateUser(name, phone, context);
    if(!success){
      Toast.show(prefs.getString('message'), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(ViewState.Idle);
      return false;
    }

    setState(ViewState.Idle);
    return success;
  }

  Future<bool> updateUserImages(File fileImage, BuildContext context) async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var success = await accountRepository.updateUserImages(fileImage, context);
    if (!success) {
      Toast.show(prefs.getString('message'), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(ViewState.Idle);
      return false;
    }

    setState(ViewState.Idle);
    return success;
  }

  Future<bool> deleteProfilePicture(BuildContext context) async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var success = await accountRepository.deleteUserImages(context);
    if (!success) {
      Toast.show(prefs.getString('message'), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(ViewState.Idle);
      return false;
    }

    setState(ViewState.Idle);
    return success;
  }
}
