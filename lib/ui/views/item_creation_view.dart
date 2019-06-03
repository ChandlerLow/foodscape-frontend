import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/core/view_models/item_creation_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/ui/views/base_view.dart';
import 'package:image_picker/image_picker.dart';

class ItemCreationView extends StatefulWidget {
  @override
  _ItemCreationViewState createState() => _ItemCreationViewState();
}

class _ItemCreationViewState extends State<ItemCreationView> {
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  File _photo;

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return BaseView<ItemCreationModel>(
      builder: (
        BuildContext context,
        ItemCreationModel model,
        Widget child,
      ) =>
          WillPopScope(
            // Overwriting the pop function of the page, so it won't jump back to
            // the main page immediately
            onWillPop: _onWillPop,
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Add Item', style: TextStyle(fontSize: 24)),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/camera.png'),
                        ),
                      ),
                      child: _photo == null
                          ? Image.asset('assets/camera.png')
                          : Image.file(_photo),
                      width: 270,
                      height: 250,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                    ),
                    FloatingActionButton.extended(
                      heroTag: null,
                      backgroundColor: Colors.grey,
                      onPressed: () => _takePhoto(),
                      label: const Text('Take a photo'),
                    ),
                    _inputTextTile('Item name', itemNameController),
                    _inputTextTile(
                      'Quantity (eg. 1/2 pint, 5 pieces)',
                      quantityController,
                    ),
                    // TODO(x): expiration date
                    _inputTextTile('Days remaining', expiryController),
                    _inputTextTile('Description', descriptionController),
                  ],
                ),
              ),

              // The button submits the item and returns to the home page
              floatingActionButton: showFab
                  ? FloatingActionButton.extended(
                      heroTag: 'main-fab',
                      backgroundColor: Colors.grey,
                      elevation: 2.0,
                      label: model.state == ViewState.Idle
                          ? const Text('Submit Item')
                          : const Text('Submitting...'),
                      onPressed: model.state == ViewState.Idle
                          ? () async {
                              // TODO(x): convert image file to store it on db
                              await model.create(
                                itemNameController.text,
                                quantityController.text,
                                expiryController.text,
                                descriptionController.text,
                              );
                              Navigator.of(context).pop(true);
                            }
                          : null,
                    )
                  : null,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            ),
          ),
    );
  }

  // Generating function for tiles
  ListTile _inputTextTile(String hintText, TextEditingController controller) {
    return ListTile(
      title: TextField(
        decoration: InputDecoration(
          hintText: hintText,
        ),
        controller: controller,
      ),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Cancel'),
                content: const Text(
                    'Are you sure you don\'t want to add a new item?'),
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

  Future<void> _takePhoto() async {
    final File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      setState(() {
        _photo = img;
      });
    }
  }
}
