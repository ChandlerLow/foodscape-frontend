import 'package:flutter/material.dart';
import 'package:frontend/core/models/item.dart';
import 'package:frontend/ui/widgets/user_list_item.dart';
import 'package:frontend/core/view_models/item_operation_model.dart';

import 'base_view.dart';

class ItemOperationsView extends StatelessWidget {
  const ItemOperationsView({this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    final Function viewItem = () {
      Navigator.pushNamed(context, '/item', arguments: item);
    };
    final Function editItem = () {
      Navigator.pushNamed(context, '/items/edit', arguments: item);
    };
    return BaseView<ItemOperationsModel>(
        builder: (
      BuildContext context,
      ItemOperationsModel model,
      Widget child,
    ) =>
            Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(item.name, style: const TextStyle(fontSize: 24)),
              ),
              body: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: MyListItem(item: item),
                        padding: const EdgeInsets.all(16.0),
                      ),
                      _makeOperation(
                          'View Item', const Icon(Icons.remove_red_eye),
                          onTap: viewItem),
                      _makeOperation('Edit Item', const Icon(Icons.edit),
                          onTap: editItem),
                      item.isCollected
                          ? _makeOperation(
                              'Mark as Available', const Icon(Icons.undo),
                              onTap: () => {
                                    model.setCollected(false, item.id),
                                    Navigator.pop(context),
                                  })
                          : _makeOperation('Item is being collected',
                              const Icon(Icons.check_circle),
                              onTap: () => {
                                    model.setCollected(true, item.id),
                                    Navigator.pop(context),
                                  }),
                      _makeOperation(
                        'Delete Item',
                        const Icon(Icons.delete),
                        onTap: () => {
                              model.deleteItem(item.id),
                              Navigator.pop(context),
                            },
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget _makeOperation(String text, Icon icon, {Function onTap}) {
    return GestureDetector (
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        height: 45.0,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(90.0),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: icon,
            ),
            Container(
              height: 30.0,
              width: 1.0,
              color: Colors.grey.withOpacity(0.5),
              margin: const EdgeInsets.only(left: 5.0, right: 15.0),
            ),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
