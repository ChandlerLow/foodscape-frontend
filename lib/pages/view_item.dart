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
          Navigator.pop(context);
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
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index){
          return makeCard(labels[index], values[index]);
        },
      ),
    );
  }

  Card makeCard(String label, String value) => Card(
    elevation: 8,
    margin: new EdgeInsets.symmetric(horizontal: 10.0),
    child: Container(
      child: makeListTile(label, value),
    )
  );

  ListTile makeListTile(String label, String value) => ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: Text(label,style: TextStyle(fontSize: 18)),
      ),
      title: Text(
        value,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
  );
}


class ViewItemWidget extends StatefulWidget {

  ViewItemWidget({Key key, String title}): super(key: key);

  @override
  _ViewItemState createState() => _ViewItemState();
}