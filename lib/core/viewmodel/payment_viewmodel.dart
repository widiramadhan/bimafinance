import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/model/payment_model.dart';
import 'package:bima_finance/core/model/promo_model.dart';
import 'package:bima_finance/core/repository/payment_repository.dart';
import 'package:bima_finance/core/repository/promo_repository.dart';
import 'package:bima_finance/core/viewmodel/base_viemodel.dart';
import 'package:bima_finance/locator.dart';
import 'package:flutter/cupertino.dart';

class PaymentViewModel extends BaseViewModel {
  PaymentRepository paymentRepository = locator<PaymentRepository>();
  List<PaymentModel>? payment;

  Future getPayment(BuildContext context) async {
    setState(ViewState.Busy);
    payment = await paymentRepository.getPayment(context);
    notifyListeners();
    setState(ViewState.Idle);
  }
}
