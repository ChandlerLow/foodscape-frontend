import 'package:frontend/core/models/categories.dart';
import 'package:frontend/core/models/item.dart';
import 'package:frontend/core/services/api.dart';
import 'package:frontend/core/view_models/base_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/locator.dart';

class ItemsModel extends BaseModel {
  final Api _api = locator<Api>();
  Map<int, List<Item>> categories;

  Future<void> getItems() async {
    setState(ViewState.Busy);
    categories = await _api.getItems();

    // Filter out categories which the user has de-selected
    final List<int> selectedCategories =
        locator<UserCategories>().getSelectedCategories().keys.toList();
    categories.removeWhere((int key, _) => !selectedCategories.contains(key));

    setState(ViewState.Idle);
  }
}
