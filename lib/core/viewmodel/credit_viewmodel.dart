import 'dart:io';

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

  Future<bool>? applyCredit(
      String? nik,
      String? dob,
      String? gender,
      String? address,
      String? phoneNumber,
      String? motherName,
      String? emergencyContact,
      String? province,
      String? city,
      String? subDistrict,
      String? postalCode,
      File? ktpPhoto,
      File? selfiePhoto,
      String? companyName,
      String? companyPhoneNumber,
      String? companyAddress,
      int? jobId,
      int? sallaryId,
      int? productId,
      int? amount,
      int? tenor,
      int? downPayment,
      int? interestPerMonth,
      int? totalInterest,
      int? totalDebt,
      int? installment,
      BuildContext context
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    var success = await creditRepository.applyCredit(
        prefs.getString('user_id'),
        nik,
        dob,
        gender,
        address,
        phoneNumber,
        motherName,
        emergencyContact,
        province,
        city,
        subDistrict,
        postalCode,
        ktpPhoto,
        selfiePhoto,
        companyName,
        companyPhoneNumber,
        companyAddress,
        jobId,
        sallaryId,
        productId,
        amount,
        tenor,
        downPayment,
        interestPerMonth,
        totalInterest,
        totalDebt,
        installment,
        context);
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
