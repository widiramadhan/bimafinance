import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/model/branch_model.dart';
import 'package:bima_finance/core/repository/branch_repository.dart';
import 'package:bima_finance/core/viewmodel/base_viemodel.dart';
import 'package:bima_finance/locator.dart';
import 'package:flutter/cupertino.dart';

class BranchViewModel extends BaseViewModel {
  BranchRepository branchRepository = locator<BranchRepository>();
  List<BranchModel>? branch;

  Future getBranch(BuildContext context) async {
    setState(ViewState.Busy);
    branch = await branchRepository.getBranch(context);
    notifyListeners();
    setState(ViewState.Idle);
  }
}
