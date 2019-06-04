import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/core/models/item.dart';
import 'package:frontend/ui/widgets/my_list_item.dart';

class ItemOperationsView extends StatelessWidget {
  const ItemOperationsView({this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    final Function viewItem = () {Navigator.pushNamed(context, '/item', arguments: item);};
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //title: Text(item.name, style: const TextStyle(fontSize: 24)),
        title: const Text('Item name', style: TextStyle(fontSize: 24)),
      ),
      body: SingleChildScrollView(
        //padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: MyListItem(item: item),
                padding: const EdgeInsets.all(16.0),
              ),
              /*Card(
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
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),*/
              _makeOperation('View Item', const Icon(Icons.remove_red_eye), onTap: viewItem),
              _makeOperation('Edit Item', const Icon(Icons.edit)),
              _makeOperation('Item is being collected', const Icon(Icons.check_circle),),
              _makeOperation('Delete Item', const Icon(Icons.delete),),
            ],
          ),
        ),
      ),
    );
  }

  Widget _makeOperation(String text, Icon icon, {Function onTap}) {
    return GestureDetector (
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        height: 45.0,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: icon,
            ),
            Container(
              padding: const EdgeInsets.only(left: 5),
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: const TextStyle(
                  decoration: TextDecoration.underline,
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