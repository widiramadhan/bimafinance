import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/model/product_model.dart';
import 'package:bima_finance/core/repository/product_repository.dart';
import 'package:bima_finance/core/viewmodel/base_viemodel.dart';
import 'package:bima_finance/locator.dart';
import 'package:flutter/cupertino.dart';

class ProductViewModel extends BaseViewModel {
  ProductRepository productRepository = locator<ProductRepository>();
  List<ProductModel>? product;

  Future getProduct(BuildContext context) async {
    setState(ViewState.Busy);
    product = await productRepository.getProduct(context);
    notifyListeners();
    setState(ViewState.Idle);
  }
}
