import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/core/models/categories.dart';
import 'package:frontend/core/models/item.dart';
import 'package:frontend/ui/shared/app_colors.dart' as app_colors;
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemView extends StatelessWidget {
  const ItemView({this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(item.name, style: const TextStyle(fontSize: 24)),
        backgroundColor: app_colors.backgroundColorPink,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'main-fab',
        backgroundColor: app_colors.backgroundColorPink,
        elevation: 2.0,
        label: const Text('Message'),
        onPressed: () async {
          String uri = 'sms:${item.userPhoneNumber}';
          if (await canLaunch(uri)) {
            await launch(uri);
          } else {
            throw 'Could not launch $uri';
          }
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          margin: const EdgeInsets.only(bottom: 75),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3.0,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Item image
              Container(
                child: Hero(
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
                          height: 170.0,
                          width: 300.0,
                          child: Stack(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.grey[100],
                                  child: Container(
                                    height: 170.0,
                                    width: 300.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/1x1.png',
                                  image: '$SPACES_BASE_URL/${item.photo}',
                                  fit: BoxFit.cover,
                                  height: 170.0,
                                  width: 300.0,
                                ),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                        ),
                ),
                alignment: Alignment.center,
                height: 175.0,
                width: 305.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      offset: Offset(0, 1),
                    )
                  ],
                ),
              ),
              // Item name
              Container(
                child: Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              // Tiles for user information
              makeListTile(
                'Expires in',
                getDaysLeft(item.expiryDate).toString() +
                    (getDaysLeft(item.expiryDate) <= 1 ? ' day' : ' days'),
              ),
              const Divider(height: 10),
              makeListTile('Quantity', item.quantity),
              const Divider(height: 10),
              makeListTile('Owner', item.userName),
              const Divider(height: 10),
              makeListTile('Location', item.userLocation),
              const Divider(height: 10),
              ListTile(
                leading: const Text(
                  'Description',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                title: Text(
                  item.description == ''
                      ? 'No description provided'
                      : item.description,
                  textAlign: TextAlign.right,
                ),
              ),
              const Divider(height: 10),
              ListTile(
                title: const Text('Stuck for choice? Try one of these'),
              ),
              //RecipeCarousel(ingredient: item.name),
            ],
          ),
        ),
      ),
    );
  }

  ListTile makeListTile(String leading, String title) {
    return ListTile(
      leading: Text(
        leading,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      title: Text(title, textAlign: TextAlign.right),
    );
  }

  int getDaysLeft(DateTime expiryDate) {
    return expiryDate.difference(DateTime.now()).inDays;
  }
}
