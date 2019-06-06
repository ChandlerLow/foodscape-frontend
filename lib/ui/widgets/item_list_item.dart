import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/core/models/item.dart';
import 'package:shimmer/shimmer.dart';

class ItemListItem extends StatelessWidget {
  const ItemListItem({this.item, this.onTap});

  final Item item;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // Item image
              Hero(
                tag: 'item-photo-${item.id}',
                child: Container(
                  child: item.photo == null || item.photo == ''
                      ? Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/camera.png'),
                            ),
                          ),
                          height: 200,
                          width: 300,
                          alignment: Alignment.center,
                        )
                      : Container(
                          child: Stack(
                            children: <Widget>[
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.grey[100],
                                child: Container(
                                  height: 200.0,
                                  width: 300.0,
                                  color: Colors.white,
                                ),
                              ),
                              FadeInImage.assetNetwork(
                                placeholder: 'assets/1x1.png',
                                image: '$SPACES_BASE_URL/${item.photo}',
                                fit: BoxFit.cover,
                                height: 200,
                                width: 300,
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                        ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 300,
                height: 20,
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
              ),
            ],
          ),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
    );
  }

  String getDaysLeft(DateTime expiryDate) {
    return expiryDate.difference(DateTime.now()).inDays.toString();
  }
}
