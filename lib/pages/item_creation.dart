import 'package:flutter/material.dart';

class _CreatedItemState extends State<CreationWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Item',
              style: TextStyle(fontSize: 24)),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.grey,
          elevation: 2.0,
          label: const Text('Submit item!'),
          onPressed: () {
            // TODO: when we return, we update the home list
            Navigator.pop(context);
          },
        ),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerFloat,
      )
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