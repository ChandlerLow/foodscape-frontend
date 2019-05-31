import 'package:flutter/material.dart';
import 'package:frontend/core/models/item.dart';

class ItemListItem extends StatelessWidget {
  const ItemListItem({this.item, this.onTap});

  final Item item;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Item image
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      // TODO(Kelvin): replace with actual image
                      image: const AssetImage('assets/banana.jpg'),
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
                        child: Text(item.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left),
                        alignment: Alignment.centerLeft,
                      ),
                      Container(
                        child: Text(
                          '${getDaysLeft(item.expiryDate)} days',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        child: Text(
                          item.userLocation,
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
    );
  }

  String getDaysLeft(DateTime expiryDate) {
    return expiryDate.difference(DateTime.now()).inDays.toString();
  }
}
