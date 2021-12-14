import 'dart:async';

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
}
