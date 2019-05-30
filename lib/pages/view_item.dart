import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class _ViewItemState extends State<ViewItemWidget> {
  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Item Name',
            style: TextStyle(fontSize: 24)),
      ),

      body: makeBody(),

      floatingActionButton: showFab ? FloatingActionButton.extended(
        heroTag: null,
        backgroundColor: Colors.grey,
        elevation: 2.0,
        label: const Text('Message'),
        onPressed: () {
          // TODO: add contact info or implement message feature
        },
      ) : null,
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget makeBody() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/banana.jpg')
                )
              ),
              width: 300,
              height: 270,
              alignment: Alignment.center,
            ),
            Container(
              child: Text("Banana",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0,10,0,0),
            ),
            Container(
              child: Text("Expires in 3 days",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0,0,0,10),
            ),
            makeListTile("Quantity", "5"),
            makeListTile("Onwer", "Jenny Xu"),
            makeListTile("Location", "Block A"),
         ],
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
      )
    );
  }

  ListTile makeListTile(String leading, String title) {
    return new ListTile(
      leading: Text(leading, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      title: new Text(title, textAlign: TextAlign.right,),
    );
  }
}


class ViewItemWidget extends StatefulWidget {

  ViewItemWidget({Key key, String title}): super(key: key);

  @override
  _ViewItemState createState() => _ViewItemState();
}