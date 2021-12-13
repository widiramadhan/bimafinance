import 'dart:io';

import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/model/news_model.dart';
import 'package:bima_finance/core/model/promo_model.dart';
import 'package:bima_finance/core/model/user_model.dart';
import 'package:bima_finance/core/repository/account_repository.dart';
import 'package:bima_finance/core/repository/news_repository.dart';
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

  UserModel? user;
  List<PromoModel>? promo;
  List<NewsModel>? news;

  bool isLogin = false;

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
}
