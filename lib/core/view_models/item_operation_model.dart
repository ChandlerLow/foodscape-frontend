import 'package:frontend/core/services/api.dart';
import 'package:frontend/core/view_models/base_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/locator.dart';

class ItemOperationsModel extends BaseModel {
  final Api _api = locator<Api>();

  Future<void> setCollected(bool isCollected, int itemId) async {
    setState(ViewState.Busy);
    await _api.setCollected(isCollected, itemId);
    setState(ViewState.Idle);
  }

  Future<void> deleteItem(int itemId) async {
    setState(ViewState.Idle);
    await _api.deleteItem(itemId);
    setState(ViewState.Busy);
  }
}