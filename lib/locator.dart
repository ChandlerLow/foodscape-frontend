import 'package:frontend/core/services/authentication_service.dart';
import 'package:frontend/core/view_models/item_creation_model.dart';
import 'package:frontend/core/view_models/items_model.dart';
import 'package:frontend/core/view_models/my_list_model.dart';
import 'package:frontend/core/view_models/register_model.dart';
import 'package:get_it/get_it.dart';

import 'core/services/api.dart';
import 'core/view_models/login_model.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => Api());

  locator.registerLazySingleton(() => LoginModel());
  locator.registerLazySingleton(() => RegisterModel());
  locator.registerLazySingleton(() => ItemsModel());
  locator.registerLazySingleton(() => MyListModel());
  locator.registerFactory(() => ItemCreationModel());
}
