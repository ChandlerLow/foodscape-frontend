import 'package:flutter/material.dart';

class _CreatedItemState extends State<CreationWidget> {
  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Item',
              style: TextStyle(fontSize: 24)),
        ),
        body: makeBody(),
        floatingActionButton: showFab ? FloatingActionButton.extended(
          backgroundColor: Colors.grey,
          elevation: 2.0,
          label: const Text('Submit Item'),
          onPressed: () {
            // TODO: when we return, we update the home list
            Navigator.pop(context);
          },
        ) : null,
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerFloat,
      )
    );
  }

  Widget makeBody() {
    return  Container(
      child: Column(
        children: <Widget>[
          Container(
            /*decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/banana.jpg')
                )
            ),*/
            color: Colors.red,
            width: 300,
            height: 270,
            alignment: Alignment.center,
          ),
          new ListTile(
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Item Name"
              ),
            ),
          ),

          new ListTile(
            title: new TextField(
              decoration: new InputDecoration(
                  hintText: "Quantity (eg. 1/2 pint, 5 pieces)"
              ),
            ),
          ),

          new ListTile(
            title: new TextField(
              decoration: new InputDecoration(
                  hintText: "Location"
              ),
            ),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: new Text('Deleting Item Addition'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text("Yes"),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text("No"),
          )
        ],
      ),
    ) ?? false;
  }
}

class CreationWidget extends StatefulWidget {

  CreationWidget({Key key, String title}): super(key: key);

  @override
  _CreatedItemState createState() => _CreatedItemState();
}