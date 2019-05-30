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
        body: makeBody(context),
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
  String output = "Select date";
  Widget makeBody(BuildContext context) {
    return  Container(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/camera.png')
                )
            ),
            //TODO remove magic numbers
            width: 270,
            height: 250,
            alignment: Alignment.center,
            padding: EdgeInsets.all(0),
          ),
          FloatingActionButton.extended(
            backgroundColor: Colors.grey,
            onPressed: () => {},
            label: const Text('Take a photo'),
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

          //TODO: expiration date
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
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    DateTime selectedDate;
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        output = "${selectedDate.year.toString()}/"
            "${selectedDate.month.toString().padLeft(2,'0')}/"
            "${selectedDate.day.toString().padLeft(2, '0')}";
      });
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