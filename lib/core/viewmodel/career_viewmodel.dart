import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/model/career_model.dart';
import 'package:bima_finance/core/model/promo_model.dart';
import 'package:bima_finance/core/repository/career_repository.dart';
import 'package:bima_finance/core/repository/promo_repository.dart';
import 'package:bima_finance/core/viewmodel/base_viemodel.dart';
import 'package:bima_finance/locator.dart';
import 'package:flutter/cupertino.dart';

class CareerViewModel extends BaseViewModel {
  CareerRepository careerRepository = locator<CareerRepository>();
  List<CareerModel>? career;

  Future getCareer(BuildContext context) async {
    setState(ViewState.Busy);
    career = await careerRepository.getCareer(context);
    notifyListeners();
    setState(ViewState.Idle);
  }
}
