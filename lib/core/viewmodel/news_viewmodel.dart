import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/model/news_model.dart';
import 'package:bima_finance/core/repository/news_repository.dart';
import 'package:bima_finance/core/viewmodel/base_viemodel.dart';
import 'package:bima_finance/locator.dart';
import 'package:flutter/cupertino.dart';

class NewsViewModel extends BaseViewModel {
  NewsRepository newsRepository = locator<NewsRepository>();
  List<NewsModel>? news;

  Future getNews(BuildContext context) async {
    setState(ViewState.Busy);
    news = await newsRepository.getNews(context);
    notifyListeners();
    setState(ViewState.Idle);
  }
}
