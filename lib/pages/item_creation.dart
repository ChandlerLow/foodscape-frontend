import 'package:flutter/material.dart';

/// Class to create a new item to give away
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
            title: const Text('Add Item', style: TextStyle(fontSize: 24)),
          ),
          body: makeBody(context),

          // The button submits the item and returns to the home page
          floatingActionButton: showFab
              ? FloatingActionButton.extended(
                  heroTag: null,
                  backgroundColor: Colors.grey,
                  elevation: 2.0,
                  label: const Text('Submit Item'),
                  onPressed: () {
                    // TODO(x): when we return, we update the home list
                    Navigator.pop(context);
                  },
                )
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ));
  }

  String output = 'Select date';

  // Function for creating the body of the page
  Widget makeBody(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: const AssetImage('assets/camera.png'))),
                // TODO(x): remove magic numbers
                width: 270,
                height: 250,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(0),
              ),
              // The button navigates to a new page to take the photo
              FloatingActionButton.extended(
                heroTag: null,
                backgroundColor: Colors.grey,
                onPressed: () => print('TODO'),
                label: const Text('Take a photo'),
              ),
              makeListTile('Item Name'),
              makeListTile('Quantity (eg. 1/2 pint, 5 pieces)'),
              makeListTile('Location'),
              makeListTile('Days reamining'),

              // TODO(x): expiration date
              /*Container(
            child: FlatButton(
              onPressed: () => _selectDate(context),
              child: Text(output),
            )
          ),*/
              /*new ListTile(
            title: new TextField(
              decoration: new InputDecoration(
                hintText: output,
              ),
            ),
            onTap:() => _selectDate(context, output),
          )*/
            ],
          )),
    );
  }

  // Generating function for tiles
  ListTile makeListTile(String hintText) {
    return ListTile(
      title: TextField(
        decoration: InputDecoration(
          hintText: hintText,
        ),
      ),
    );
  }

  // Overwriting the pop function of the page, so it won't jump back to the main
  // page immediately
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Deleting Item Addition'),
                content: const Text('Are you sure?'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  ),
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Yes'),
                  )
                ],
              ),
        ) ??
        false;
  }
}

class CreationWidget extends StatefulWidget {
  // ignore: avoid_unused_constructor_parameters
  CreationWidget({Key key, String title}) : super(key: key);

  @override
  _CreatedItemState createState() => _CreatedItemState();
}
