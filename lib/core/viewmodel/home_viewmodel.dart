import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/model/news_model.dart';
import 'package:bima_finance/core/model/notification_model.dart';
import 'package:bima_finance/core/model/ostanding_model.dart';
import 'package:bima_finance/core/model/promo_model.dart';
import 'package:bima_finance/core/model/user_model.dart';
import 'package:bima_finance/core/repository/account_repository.dart';
import 'package:bima_finance/core/repository/news_repository.dart';
import 'package:bima_finance/core/repository/notification_repository.dart';
import 'package:bima_finance/core/repository/ostanding_repository.dart';
import 'package:bima_finance/core/repository/promo_repository.dart';
import 'package:bima_finance/core/viewmodel/base_viemodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../../locator.dart';

class HomeViewModel extends BaseViewModel {
  AccountRepository accountRepository = locator<AccountRepository>();
  PromoRepository promoRepository = locator<PromoRepository>();
  NewsRepository newsRepository = locator<NewsRepository>();
  NotificationRepository notificationRepository = locator<NotificationRepository>();
  OstandingRepository ostandingRepository = locator<OstandingRepository>();

  UserModel? user;
  List<PromoModel>? promo;
  List<NewsModel>? news;
  List<NotificationModel>? notification;
  // OstandingModel? ostanding;

  bool isLogin = false;

  Future init(BuildContext context) async {
    await getNews(context);
    await getPromo(context);
    await getNotification(context);
    // await getOstanding(context);
    
    await checkSessionLogin();
    if(isLogin == true){
      await getUser(context);
      // await getOstanding(context);
    }
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

  Future getPromo(BuildContext context) async {
    setState(ViewState.Busy);
    promo = await promoRepository.getPromo(context);
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future getNews(BuildContext context) async {
    setState(ViewState.Busy);
    news = await newsRepository.getNews(context);
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future getNotification(BuildContext context) async {
    setState(ViewState.Busy);
    notification = await notificationRepository.getNotification(context);
    notifyListeners();
    setState(ViewState.Idle);
  }

  // Future<bool>? getOstanding(String? nik, String total, BuildContext context) async {
  //  SharedPreferences prefs = await SharedPreferences.getInstance();
  //  setState(ViewState.Busy);
  //  var success = await ostandingRepository.getOstanding(prefs.getString('user_id'), nik, total, context);
  //  setState(ViewState.Idle);
  //  if(success){
  //    return true;
  //  }else{
  //    Toast.show(prefs.getString('message'),context,duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //    return false;
  //  }
  // }

  Future<bool> updateStatusNotification(int notificationId, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    var success = await notificationRepository.updateStatusNotification(notificationId, context);
    setState(ViewState.Idle);
    if (success) {
      return true;
    } else {
      Toast.show(prefs.getString('message'), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(ViewState.Idle);
      return false;
    }
  }
}
