import 'package:bima_finance/core/repository/account_repository.dart';
import 'package:bima_finance/core/repository/auth_repository.dart';
import 'package:bima_finance/core/repository/branch_repository.dart';
import 'package:bima_finance/core/repository/career_repository.dart';
import 'package:bima_finance/core/repository/news_repository.dart';
import 'package:bima_finance/core/repository/product_repository.dart';
import 'package:bima_finance/core/repository/promo_repository.dart';
import 'package:bima_finance/core/viewmodel/account_viewmodel.dart';
import 'package:bima_finance/core/viewmodel/auth_viewmodel.dart';
import 'package:bima_finance/core/viewmodel/branch_viewmodel.dart';
import 'package:bima_finance/core/viewmodel/career_viewmodel.dart';
import 'package:bima_finance/core/viewmodel/home_viewmodel.dart';
import 'package:bima_finance/core/viewmodel/news_viewmodel.dart';
import 'package:bima_finance/core/viewmodel/product_viewmodel.dart';
import 'package:bima_finance/core/viewmodel/promo_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthRepository());
  locator.registerLazySingleton(() => AccountRepository());
  locator.registerLazySingleton(() => BranchRepository());
  locator.registerLazySingleton(() => NewsRepository());
  locator.registerLazySingleton(() => PromoRepository());
  locator.registerLazySingleton(() => ProductRepository());
  locator.registerLazySingleton(() => CareerRepository());

  locator.registerFactory(() => AuthViewModel());
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => AccountViewModel());
  locator.registerFactory(() => BranchViewModel());
  locator.registerFactory(() => NewsViewModel());
  locator.registerFactory(() => PromoViewModel());
  locator.registerFactory(() => ProductViewModel());
  locator.registerFactory(() => CareerViewModel());
}
