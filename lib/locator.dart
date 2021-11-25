import 'package:bima_finance/core/repository/account_repository.dart';
import 'package:bima_finance/core/repository/auth_repository.dart';
import 'package:bima_finance/core/viewmodel/account_viewmodel.dart';
import 'package:bima_finance/core/viewmodel/auth_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // locator.registerLazySingleton(() => SliderRepository());
  // locator.registerLazySingleton(() => ProductRepository());
  locator.registerLazySingleton(() => AuthRepository());
  // locator.registerLazySingleton(() => CartRepository());
  locator.registerLazySingleton(() => AccountRepository());
  // locator.registerLazySingleton(() => AddressRepository());
  // locator.registerLazySingleton(() => VoucherRepository());
  // locator.registerLazySingleton(() => ShipmentRepository());
  // locator.registerLazySingleton(() => OrderRepository());
  //
  // locator.registerFactory(() => HomeViewModel());
  // locator.registerFactory(() => ProductViewModel());
  locator.registerFactory(() => AuthViewModel());
  // locator.registerFactory(() => CartViewModel());
  // locator.registerFactory(() => CheckOutViewModel());
  locator.registerFactory(() => AccountViewModel());
  // locator.registerFactory(() => AddressViewModel());
  // locator.registerFactory(() => OrderViewModel());
}
