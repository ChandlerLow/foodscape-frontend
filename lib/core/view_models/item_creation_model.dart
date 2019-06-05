import 'dart:io';

import 'package:frontend/core/services/api.dart';
import 'package:frontend/core/view_models/base_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/locator.dart';

class ItemCreationModel extends BaseModel {
  final Api _api = locator<Api>();

  Future<void> create(
    String itemName,
    String quantity,
    String expiry,
    String description,
    File photo,
    int categoryId,
  ) async {
    setState(ViewState.Busy);
    await _api.createItem(
      itemName,
      quantity,
      DateTime.now().add(Duration(days: int.parse(expiry))).toIso8601String(),
      description,
      photo,
      categoryId,
    );
    setState(ViewState.Idle);
  }
}
