import 'package:frontend/core/models/categories.dart';
import 'package:frontend/core/models/item.dart';
import 'package:frontend/core/services/api.dart';
import 'package:frontend/core/view_models/base_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/locator.dart';

class ItemsModel extends BaseModel {
  final Api _api = locator<Api>();
  Map<int, List<Item>> categories;
  Map<int, List<Item>> nonEmptyCategories;

  Future<void> getItems() async {
    setState(ViewState.Busy);

    final List<int> selectedCategories =
        locator<UserCategories>().getSelectedCategories().keys.toList();

    // Filter out categories which the user has de-selected and non-empty
    // categories
    categories = await _api.getItems()
      ..removeWhere((int key, _) => !selectedCategories.contains(key))
      ..removeWhere((_, List<Item> items) => items.isEmpty);

    setState(ViewState.Idle);
  }
}
