import 'package:flutter/material.dart';
import 'package:frontend/core/models/categories.dart';
import 'package:frontend/core/models/item.dart';
import 'package:frontend/core/models/user.dart';
import 'package:frontend/core/view_models/items_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/ui/widgets/item_list_item.dart';
import 'package:provider/provider.dart';

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
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () async {
                  await Navigator.of(context).pushNamed('/items/filter');
                  model.getItems();
                },
              )
            ],
          ),
          body: Container(
            child: RefreshIndicator(
              child: model.state == ViewState.Idle
                  ? getCategoriesUi(model.categories)
                  : Center(child: const CircularProgressIndicator()),
              onRefresh: model.getItems,
            ),
          ),
          // FAB to add an item
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[

                IconButton(icon: Icon(Icons.home), color: Colors.white, iconSize: 40,
                  onPressed: () {},),
                IconButton(icon: Icon(Icons.person), color: Colors.white, iconSize: 40, onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },),
                IconButton(
                  icon: Icon(Icons.home),
                  color: Colors.white,
                  iconSize: 40,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  color: Colors.white,
                  iconSize: 40,
                  onPressed: () {},
                ),
              ],
            ),
            color: Colors.grey,
            shape: CircularNotchedRectangle(),
          ),
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
            return item;
          },
          itemCount: items.length,
        ),
  );
 
  Widget getCategoriesUi(Map<int, List<Item>> categories) {
    final List<int> categoryKeys = categories.keys.toList();
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int i) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(defaultCategories[categoryKeys[i]].name),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      categories[categoryKeys[i]].map<Widget>((Item item) {
                    return ItemListItem(
                      item: item,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/item',
                          arguments: item,
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Drawer makeDrawer(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        // TODO(Kelvin): get name of authenticated user
        UserAccountsDrawerHeader(
          accountName: Text(Provider.of<User>(context).name,
              style: TextStyle(fontSize: 24)),
          accountEmail:
              Text('${Provider.of<User>(context).name}18@bristol.ac.uk'),
          currentAccountPicture: const CircleAvatar(
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
