import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/model/tenor_model.dart';
import 'package:bima_finance/core/repository/tenor_repository.dart';
import 'package:bima_finance/core/viewmodel/base_viemodel.dart';
import 'package:bima_finance/locator.dart';
import 'package:flutter/cupertino.dart';

class TenorViewModel extends BaseViewModel {
  TenorRepository tenorRepository = locator<TenorRepository>();
  List<TenorModel>? tenor;

  Future getTenor(BuildContext context) async {
    setState(ViewState.Busy);
    tenor = await tenorRepository.getTenor(context);
    notifyListeners();
    setState(ViewState.Idle);
  }
}
