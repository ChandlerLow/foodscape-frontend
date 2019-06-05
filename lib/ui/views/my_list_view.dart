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
        final bool last = items.length == (i + 1);
        /*final Widget item = GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/operations');
          },
          child: Card(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/camera.png'),
                      ),
                    ),
                    width: 300,
                    height: 150,
                    padding: const EdgeInsets.only(right: 10),
                    alignment: Alignment.center,
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Container>[
                        Container(
                          // ignore: prefer_const_constructors
                          child: Text('Name',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left),
                          alignment: Alignment.centerLeft,
                        ),
                        Container(
                          child: const Text(
                            'Availability',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right,
                          ),
                          alignment: Alignment.centerRight,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    width: 300,
                    height: 20,
                  ),
                ],
              ),
              padding: const EdgeInsets.only(top: 20),
              width: 400,
              height: 210,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        );*/
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
