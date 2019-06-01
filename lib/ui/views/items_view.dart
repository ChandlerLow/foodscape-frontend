import 'package:flutter/material.dart';
import 'package:frontend/core/models/item.dart';
import 'package:frontend/core/view_models/items_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/ui/widgets/item_list_item.dart';

import 'base_view.dart';

class ItemsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ItemsModel>(
      onModelReady: (ItemsModel model) {
        model.getItems();
      },
      builder: (BuildContext context, ItemsModel model, Widget child) {
        final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Ramsay Hall'),
          ),
          body: Container(
            child: Center(
              child: RefreshIndicator(
                child: model.state == ViewState.Idle
                    ? getItemsUi(model.items)
                    : Center(child: const CircularProgressIndicator()),
                onRefresh: model.getItems,
              ),
            ),
          ),
          drawer: makeDrawer(context),
          // FAB to add an item
          floatingActionButton: showFab
              ? FloatingActionButton(
                  heroTag: 'main-fab',
                  backgroundColor: Colors.grey,
                  elevation: 2.0,
                  child: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.pushNamed(context, '/items/add');
                  },
                )
              : null,
        );
      },
    );
  }

  Widget getItemsUi(List<Item> items) => Container(
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (BuildContext context, int i) {
            final bool last = items.length == (i + 1);
            final Widget item = ItemListItem(
              item: items[i],
              onTap: () {
                Navigator.pushNamed(context, '/item', arguments: items[i]);
              },
            );
            if (last) {
              return Container(
                child: item,
                padding: EdgeInsets.only(bottom: 60),
              );
            } else {
              return item;
            }
          },
          itemCount: items.length,
        ),
      );

  Drawer makeDrawer(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        // TODO(Kelvin): get name of authenticated user
        const UserAccountsDrawerHeader(
          accountEmail: Text('jenny.xu18@bristol.ac.uk'),
          accountName: Text('Jenny Xu', style: TextStyle(fontSize: 24)),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.pinkAccent,
            child: Text('JX', style: TextStyle(fontSize: 24)),
          ),
        ),
        ListTile(
          title: const Text('My Items', style: TextStyle(fontSize: 18)),
          onTap: () {
            // TODO(x): add action
          },
        ),
        ListTile(
          title: const Text('My Details', style: TextStyle(fontSize: 18)),
          onTap: () {
            // TODO(x): add action
          },
        ),
      ]),
    );
  }
}
