import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class _ViewItemState extends State<ViewItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Item Name',
            style: TextStyle(fontSize: 24)),
      ),

      body: makeBody(),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.grey,
        elevation: 2.0,
        label: const Text('Message'),
        onPressed: () {
          // TODO: add contact info or implement message feature
        },
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget makeBody() {
    List<String> labels = ["Quantity", "Owner", "Location"];
    List<String> values = ["5", "Jenny Xu", "Block A"];
    return Container(
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
          new ListTile(
            leading: Text("Quantity", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            title: new Text("5", textAlign: TextAlign.right,),
          ),
          new ListTile(
            leading: Text("Owner", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            title: new Text("Jenny Xu", textAlign: TextAlign.right,),
          ),
          new ListTile(
            leading: Text("Location", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            title: new Text("Block A", textAlign: TextAlign.right,),
          ),
       ],
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
    );
  }
}


class ViewItemWidget extends StatefulWidget {

  ViewItemWidget({Key key, String title}): super(key: key);

  @override
  _ViewItemState createState() => _ViewItemState();
}