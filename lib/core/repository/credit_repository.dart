import 'dart:async';
import 'dart:io';

import 'package:bima_finance/core/constant/api.dart';
import 'package:bima_finance/core/helper/dio_exception.dart';
import 'package:bima_finance/core/model/credit_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class CreditRepository extends ChangeNotifier {
  Response? response;
  Dio dio = new Dio();

  Future<CreditModel?> simulationCredit(int productId, int loanAmount, int price, int tenor, int dp, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio.post(Api().simulationCredit,
          options: Options(headers: {"Accept": "application/json",}),
          data: FormData.fromMap({
            'product_id': productId,
            'loan_amount': loanAmount,
            'price': price,
            'tenor': tenor,
            'dp': dp,
          })).timeout(Duration (seconds: Api().timeout));
      if (response?.data['isSuccess'] == true) {
        notifyListeners();
        final Map<String, dynamic> parsed = response?.data['data'];
        final dataCredit = CreditModel.fromJson(parsed);
        return dataCredit;
      } else {
        Toast.show(response?.data['message'], context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        return null;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      prefs.setString('message', errorMessage);
      Toast.show(errorMessage, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return null;
    }
  }

  Future<bool> applyCredit(
      String? userId,
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
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String ktpFile = ktpPhoto!.path.split('/').last;
      var imagesKTP = await MultipartFile.fromFile(
        ktpPhoto.path,
        filename: ktpFile,
      );
      String selfieFile = selfiePhoto!.path.split('/').last;
      var imagesSelfie = await MultipartFile.fromFile(
        selfiePhoto.path,
        filename: selfieFile,
      );

      response = await dio.post(Api().applyCredit,
          options: Options(headers: {"Accept": "application/json",}),
          data: FormData.fromMap({
            'user_id': userId,
            'nik': nik,
            'dob': dob,
            'gender': gender,
            'address': address,
            'phone_number': phoneNumber,
            'mother_name': motherName,
            'emergency_contact': emergencyContact,
            'province': province,
            'city': city,
            'sub_district': subDistrict,
            'postal_code': postalCode,
            'ktp_photo': imagesKTP,
            'selfie_photo': imagesSelfie,
            'company_name': companyName,
            'company_phone_number': companyPhoneNumber,
            'company_address': companyAddress,
            'job_id': jobId,
            'sallary_id': sallaryId,
            'product_id': productId,
            'amount': amount,
            'tenor': tenor,
            'dp': downPayment,
            'interest_per_month': interestPerMonth,
            'total_interest': totalInterest,
            'total_debt': totalDebt,
            'instalment': installment,
          })).timeout(Duration (seconds: Api().timeout));
      if (response?.data['isSuccess'] == true) {
        prefs.setString('message', response?.data['message']);
        return true;
      } else {
        prefs.setString('message', response?.data['message']);
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      prefs.setString('message', errorMessage);
      return false;
    }
  }
}
