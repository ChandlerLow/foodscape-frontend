import 'package:flutter/material.dart';
import 'package:frontend/core/models/item.dart';
import 'package:frontend/core/view_models/user_items_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/ui/widgets/user_list_item.dart';

import 'base_view.dart';

class UserItemsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<UserItemsModel>(
      onModelReady: (UserItemsModel model) {
        model.getItems();
      },
      builder: (BuildContext context, UserItemsModel model, Widget child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('My Items'),
          ),
          body: Container(
            child: Center(
              //child: getItemsUi(items)
              child: RefreshIndicator(
                child: model.state == ViewState.Idle
                    ? getItemsUi(model.items)
                    : Center(child: const CircularProgressIndicator()),
                onRefresh: model.getItems,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getItemsUi(List<Item> items) => Container(
    child: ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext context, int i) {
        final Widget item = GestureDetector(
          child: MyListItem(item: items[i]),
          onTap: () {
            Navigator.pushNamed(context, '/operations', arguments: items[i]);
          },
        );
        return item;
      },
      itemCount: items.length,
    ),
  );

}
