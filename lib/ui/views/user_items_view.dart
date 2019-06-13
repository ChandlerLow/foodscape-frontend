import 'package:flutter/material.dart';
import 'package:frontend/core/models/item.dart';
import 'package:frontend/core/view_models/user_items_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/ui/shared/app_colors.dart' as app_colors;
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
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: app_colors.backgroundColorPink,
            centerTitle: true,
            title: const Text(
              'My Items',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: RefreshIndicator(
                child: model.state == ViewState.Idle
                    ? (model.items.isNotEmpty
                        ? getItemsUi(model.items, model)
                        : const Center(
                            child: Text('None found! Why not add an item?'),
                          ))
                    : const Center(child: CircularProgressIndicator()),
                onRefresh: model.getItems,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getItemsUi(List<Item> items, UserItemsModel model) => Container(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemBuilder: (BuildContext context, int i) {
            return UserListItem(
              item: items[i],
              onTap: () async {
                await Navigator.pushNamed(
                  context,
                  '/operations',
                  arguments: items[i],
                );
                model.getItems();
              },
            );
          },
          itemCount: items.length,
        ),
      );
}
