import 'package:flutter/material.dart';
import 'package:frontend/core/models/item.dart';

class ItemView extends StatelessWidget {
  const ItemView({this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

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
                child: Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/banana.jpg'),
                    ),
                  ),
                  width: 300,
                  height: 270,
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
            ],
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
        ),
      ),
      // With the button we can contact the owner of the item we are looking at
      floatingActionButton: showFab
          ? FloatingActionButton.extended(
              heroTag: 'main-fab',
              backgroundColor: Colors.grey,
              elevation: 2.0,
              label: const Text('Message'),
              onPressed: () {
                // TODO(x): add contact info or implement message feature
              },
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
