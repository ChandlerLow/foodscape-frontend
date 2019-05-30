import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Page to view item information (e.g. owner, location)
class _ViewItemState extends State<ViewItemWidget> {
  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Item Name', style: TextStyle(fontSize: 24)),
      ),

      body: makeBody(),

      // With the button we can contact the owner of the item we are looking at
      floatingActionButton: showFab
          ? FloatingActionButton.extended(
              heroTag: null,
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

  // Function for creating the body of the page
  Widget makeBody() {
    return SingleChildScrollView(
        child: Container(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: const AssetImage('assets/banana.jpg'))),
            width: 300,
            height: 270,
            alignment: Alignment.center,
          ),
          Container(
            child: const Text('Banana',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          ),
          Container(
            child: const Text('Expires in 3 days',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          ),
          makeListTile('Quantity', '5'),
          makeListTile('Onwer', 'Jenny Xu'),
          makeListTile('Location', 'Block A'),
        ],
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
    ));
  }

  // Generating function for tiles
  ListTile makeListTile(String leading, String title) {
    return ListTile(
      leading: Text(leading,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      title: Text(title, textAlign: TextAlign.right),
    );
  }
}

class ViewItemWidget extends StatefulWidget {
  // ignore: avoid_unused_constructor_parameters
  ViewItemWidget({Key key, String title}) : super(key: key);

  @override
  _ViewItemState createState() => _ViewItemState();
}
