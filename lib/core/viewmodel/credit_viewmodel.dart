import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/model/credit_model.dart';
import 'package:bima_finance/core/model/job_model.dart';
import 'package:bima_finance/core/model/product_model.dart';
import 'package:bima_finance/core/model/sallary_model.dart';
import 'package:bima_finance/core/repository/credit_repository.dart';
import 'package:bima_finance/core/repository/master_repository.dart';
import 'package:bima_finance/core/repository/product_repository.dart';
import 'package:bima_finance/core/viewmodel/base_viemodel.dart';
import 'package:bima_finance/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class CreditViewModel extends BaseViewModel {
  ProductRepository productRepository = locator<ProductRepository>();
  CreditRepository creditRepository = locator<CreditRepository>();
  MasterRepository masterRepository = locator<MasterRepository>();
  List<ProductModel>? product;
  List<JobModel>? job;
  List<SallaryModel>? sallary;
  CreditModel? credit;


  Future getProduct(BuildContext context) async {
    setState(ViewState.Busy);
    product = await productRepository.getProduct(context);
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future getJob(BuildContext context) async {
    setState(ViewState.Busy);
    job = await masterRepository.getJob(context);
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future getSallary(BuildContext context) async {
    setState(ViewState.Busy);
    sallary = await masterRepository.getSallary(context);
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future<CreditModel> simulationCredit(
      int productId,
      String loanAmount,
      String price,
      String tenor,
      String dp,
      BuildContext context) async {
    setState(ViewState.Busy);
    int amount = int.parse(loanAmount.replaceAll("Rp. ", "").replaceAll(".", ""));
    int prices = int.parse(price.substring(0, price.length - 3).replaceAll(".", "").replaceAll(",", ""));
    int downPayment = int.parse(dp.substring(0, dp.length - 3).replaceAll(".", "").replaceAll(",", ""));
    credit = await creditRepository.simulationCredit(
        productId,
        amount,
        prices,
        int.parse(tenor),
        downPayment,
        context);
    notifyListeners();
    setState(ViewState.Idle);
    return credit!;
  }
}
