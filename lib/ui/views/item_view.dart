import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/core/models/categories.dart';
import 'package:frontend/core/models/item.dart';
import 'package:shimmer/shimmer.dart';

class ItemView extends StatelessWidget {
  const ItemView({this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(item.name, style: const TextStyle(fontSize: 24)),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              // Item image
              Hero(
                tag: 'item-photo-${item.id}',
                child: item.photo == null || item.photo == ''
                    ? Container(
                        child: Icon(
                          defaultCategories[item.categoryId].icon,
                          size: 50,
                          color: Colors.black,
                        ),
                        alignment: Alignment.center,
                        height: 170.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFABBC5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFABBC5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height: 170.0,
                        width: 300.0,
                        child: Stack(
                          children: <Widget>[
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.grey[100],
                              child: Container(
                                height: 170.0,
                                width: 300.0,
                                color: Colors.white,
                              ),
                            ),
                            FadeInImage.assetNetwork(
                              placeholder: 'assets/1x1.png',
                              image: '$SPACES_BASE_URL/${item.photo}',
                              fit: BoxFit.cover,
                              height: 170.0,
                              width: 300.0,
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                      ),
              ),
              // Item name
              Container(
                child: Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              ),
              // Item expiry
              Container(
                child: Text(
                  'Expires in ${getDaysLeft(item.expiryDate)} day(s)',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              ),
              // Tiles for user information
              makeListTile('Quantity', item.quantity),
              makeListTile('Owner', item.userName),
              makeListTile('Location', item.userLocation),
              ListTile(
                title: const Text('Stuck for choice? Try one of these'),
              ),
              RecipeCarousel(ingredient: item.name),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              FloatingActionButton.extended(
                heroTag: 'main-fab',
                backgroundColor: Colors.grey,
                elevation: 2.0,
                label: const Text('Message'),
                onPressed: () {
                  // TODO(x): add contact info or implement message feature
                },
              )
            ],
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
        ),
      ),
      // With the button we can contact the owner of the item we are looking at
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.only(bottom: 20),
      ),
    );
  }

  ListTile makeListTile(String leading, String title) {
    return ListTile(
      leading: Text(leading,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      title: Text(title, textAlign: TextAlign.right),
    );
  }

  String getDaysLeft(DateTime expiryDate) {
    return expiryDate.difference(DateTime.now()).inDays.toString();
  }
}
