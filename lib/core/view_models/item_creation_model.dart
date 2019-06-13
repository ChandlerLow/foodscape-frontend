import 'dart:io';

import 'package:frontend/core/services/api.dart';
import 'package:frontend/core/view_models/base_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/locator.dart';

class ItemCreationModel extends BaseModel {
  final Api _api = locator<Api>();
  bool isCreated = false;

  Future<void> create(
    String itemName,
    String quantity,
    String expiry,
    String description,
    File photo,
    int categoryId,
  ) async {
    setState(ViewState.Busy);

    final List<Future<void>> futures = [];
    futures.add(Future<void>.delayed(const Duration(seconds: 1)));
    futures.add(_api
        .createItem(
          itemName,
          quantity,
          DateTime.now()
              .add(Duration(days: int.parse(expiry)))
              .toIso8601String(),
          description,
          photo,
          categoryId,
        )
        .then((bool isCreated) => this.isCreated = isCreated));

    await Future.wait(futures);
    setState(ViewState.Idle);
  }
}
