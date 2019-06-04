import 'package:flutter/material.dart';
import 'package:frontend/core/models/categories.dart';
import 'package:frontend/core/models/item.dart';
import 'package:frontend/core/models/user.dart';
import 'package:frontend/core/view_models/items_model.dart';
import 'package:frontend/core/view_models/my_list_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/ui/widgets/item_list_item.dart';
import 'package:frontend/ui/widgets/my_list_item.dart';
import 'package:provider/provider.dart';

import 'base_view.dart';

class MyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<MyListModel>(
      onModelReady: (MyListModel model) {
        model.getItems();
      },
      builder: (BuildContext context, MyListModel model, Widget child) {
        List<int> items = [1,2,3];
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('My Item List'),
          ),
          body: Container(
            child: Center(
              //child: getItemsUi(items)
              child: RefreshIndicator(
                child: model.state == ViewState.Idle
                    ? getCategoriesUi(model.categories)
                    : Center(child: const CircularProgressIndicator()),
                onRefresh: model.getItems,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getCategoriesUi(Map<int, List<Item>> categories) {
    final List<int> categoryKeys = categories.keys.toList();
    return Container(
      child: ListView.builder(
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
                    return GestureDetector(
                      child: MyListItem(
                        item: item,
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/operations',
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
}
