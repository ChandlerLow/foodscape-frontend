import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/core/models/item.dart';
import 'package:frontend/ui/widgets/recipe_carousel.dart';

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
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/camera.png'),
                          ),
                        ),
                        width: 300,
                        height: 150,
                        padding: const EdgeInsets.only(right: 10),
                        alignment: Alignment.center,
                      )
                    : Container(
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/camera.png',
                          image: '$SPACES_BASE_URL/${item.photo}',
                        ),
                        width: 300,
                        height: 150,
                        padding: const EdgeInsets.only(right: 10),
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
              ListTile(title: const Text('Stuck for choice? Try one of these'),),
              RecipeCarousel(ingredient: item.name),
              const Padding(padding: EdgeInsets.only(bottom: 10),),
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
      bottomNavigationBar: const Padding(padding: EdgeInsets.only(bottom: 20),),
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
