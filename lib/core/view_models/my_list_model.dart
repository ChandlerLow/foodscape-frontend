import 'package:frontend/core/models/item.dart';
import 'package:frontend/core/services/api.dart';
import 'package:frontend/core/view_models/base_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/locator.dart';

class MyListModel extends BaseModel {
  final Api _api = locator<Api>();
  List<Item>  items;

  Future<void> getItems() async {
    setState(ViewState.Busy);
    items = await _api.getUserItems();
    setState(ViewState.Idle);
  }
}