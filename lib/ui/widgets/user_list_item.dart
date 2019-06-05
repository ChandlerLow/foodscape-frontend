import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/core/models/item.dart';

class MyListItem extends StatelessWidget {
  const MyListItem({this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // Item image
              Hero(
                tag: 'item-photo-${item.id}',
                child: item.photo == null || item.photo == ''
                    ? Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/camera.png'),
                          ),
                        ),
                        width: 300,
                        height: 150,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                      )
                    : Container(
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/camera.png',
                          image: '$SPACES_BASE_URL/${item.photo}',
                        ),
                        width: 300,
                        height: 150,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                      ),
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
                      // TODO(x): add item availability
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
          width: 300,
          height: 210,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10));
  }
}
