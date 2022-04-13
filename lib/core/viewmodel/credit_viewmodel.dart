import 'dart:io';

import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/model/branch_model.dart';
import 'package:bima_finance/core/model/contract_model.dart';
import 'package:bima_finance/core/model/credit_model.dart';
import 'package:bima_finance/core/model/job_model.dart';
import 'package:bima_finance/core/model/ostanding_model.dart';
import 'package:bima_finance/core/model/product_model.dart';
import 'package:bima_finance/core/model/sallary_model.dart';
import 'package:bima_finance/core/model/tenor_model.dart';
import 'package:bima_finance/core/model/branch_model.dart';
import 'package:bima_finance/core/repository/branch_repository.dart';
import 'package:bima_finance/core/repository/credit_repository.dart';
import 'package:bima_finance/core/repository/master_repository.dart';
import 'package:bima_finance/core/repository/ostanding_repository.dart';
import 'package:bima_finance/core/repository/product_repository.dart';
import 'package:bima_finance/core/repository/tenor_repository.dart';
import 'package:bima_finance/core/repository/branch_repository.dart';
import 'package:bima_finance/core/viewmodel/base_viemodel.dart';
import 'package:bima_finance/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class CreditViewModel extends BaseViewModel {
  ProductRepository productRepository = locator<ProductRepository>();
  CreditRepository creditRepository = locator<CreditRepository>();
  MasterRepository masterRepository = locator<MasterRepository>();
  TenorRepository tenorRepository = locator<TenorRepository>();
  BranchRepository branchRepository = locator<BranchRepository>();
  // OstandingRepository ostandingRepository = locator<OstandingRepository>();
  List<ProductModel>? product;
  List<JobModel>? job;
  List<SallaryModel>? sallary;
  List<ContractModel>? contract;
  List<TenorModel>? tenor;
  List<BranchModel>? branch;
  // List<OstandingModel>? ostanding;
  CreditModel? credit;
  // List<TenorModel>? tenor;
  // List<BranchModel>? branch;


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

  Future getContract(BuildContext context) async {
    setState(ViewState.Busy);
    contract = await creditRepository.getContract(context);
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future getTenor(BuildContext context) async {
    setState(ViewState.Busy);
    tenor = await tenorRepository.getTenor(context);
    notifyListeners();
    setState(ViewState.Idle);
  }

   Future getBranch(BuildContext context) async {
    setState(ViewState.Busy);
    branch = await branchRepository.getBranch(context);
    notifyListeners();
    setState(ViewState.Idle);
  }

  // Future getOstanding(BuildContext context) async {
  //   setState(ViewState.Busy);
  //   ostanding = await ostandingRepository.getOstanding(context);
  //   notifyListeners();
  //   setState(ViewState.Idle);
  // }

  Future<CreditModel> simulationCredit(
      int productId,
      String loanAmount,
      String price,
      String tenor,
      String dp,
      int branchId,
      BuildContext context) async {
    setState(ViewState.Busy);
    int amount = int.parse(loanAmount.replaceAll("Rp. ", "").replaceAll(".", ""));
    int prices = int.parse(price.replaceAll(".", "").replaceAll(",", ""));
    int downPayment = int.parse(dp.replaceAll(".", "").replaceAll(",", ""));

    print(amount);
    print(prices);
    print(downPayment);
    credit = await creditRepository.simulationCredit(
        productId,
        amount,
        prices,
        int.parse(tenor),
        downPayment,
        branchId,
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
      int? branchId,
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
        branchId,
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
