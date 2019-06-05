import 'dart:io';

import 'package:frontend/core/services/api.dart';
import 'package:frontend/core/view_models/base_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/locator.dart';

// TODO(x): remove duplication
class ItemEditingModel extends BaseModel {
  final Api _api = locator<Api>();

  Future<void> edit(
      String itemName,
      String quantity,
      String expiry,
      String description,
      File photo,
      String originalPhoto,
      ) async {
    setState(ViewState.Busy);
    await _api.editItem(
      itemName,
      quantity,
      DateTime.now().add(Duration(days: int.parse(expiry))).toIso8601String(),
      description,
      photo,
      originalPhoto,
    );
    setState(ViewState.Idle);
  }
}