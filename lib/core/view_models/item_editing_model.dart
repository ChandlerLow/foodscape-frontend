import 'dart:io';

import 'package:frontend/core/models/item.dart';
import 'package:frontend/core/services/api.dart';
import 'package:frontend/core/view_models/base_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/locator.dart';

class ItemEditingModel extends BaseModel {
  final Api _api = locator<Api>();

  Future<void> edit(
    Item item,
    String newName,
    String newQuantity,
    String newExpiry,
    String newDescription,
    int newCategoryId,
    File newPhoto,
  ) async {
    setState(ViewState.Busy);
    await _api.editItem(
      item,
      newName,
      newQuantity,
      DateTime.now()
          .add(Duration(days: int.parse(newExpiry)))
          .toIso8601String(),
      newDescription,
      newCategoryId,
      newPhoto,
    );
    setState(ViewState.Idle);
  }
}
