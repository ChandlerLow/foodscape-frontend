import 'package:frontend/core/view_models/items_model.dart';
import 'package:get_it/get_it.dart';

import 'core/services/api.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => ItemsModel());
  locator.registerLazySingleton(() => Api());
}
