import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/model/faq_model.dart';
import 'package:bima_finance/core/repository/faq_repository.dart';
import 'package:bima_finance/core/viewmodel/base_viemodel.dart';
import 'package:bima_finance/locator.dart';
import 'package:flutter/cupertino.dart';

class FaqViewModel extends BaseViewModel {
  FaqRepository faqRepository = locator<FaqRepository>();
  List<FaqModel>? faq;

  Future getFaq(BuildContext context) async {
    setState(ViewState.Busy);
    faq = await faqRepository.getFaq(context);
    notifyListeners();
    setState(ViewState.Idle);
  }
}
