import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/model/promo_model.dart';
import 'package:bima_finance/core/repository/promo_repository.dart';
import 'package:bima_finance/core/viewmodel/base_viemodel.dart';
import 'package:bima_finance/locator.dart';
import 'package:flutter/cupertino.dart';

class PromoViewModel extends BaseViewModel {
  PromoRepository promoRepository = locator<PromoRepository>();
  List<PromoModel>? promo;

  Future getPromo(BuildContext context) async {
    setState(ViewState.Busy);
    promo = await promoRepository.getPromo(context);
    notifyListeners();
    setState(ViewState.Idle);
  }
}
