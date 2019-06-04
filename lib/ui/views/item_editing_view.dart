import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/core/models/item.dart';
import 'package:frontend/core/view_models/item_editing_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/ui/views/base_view.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';

// TODO(x): refactor with item_creation_view: remove duplications
// We are only using different buttons (update <-> add), bar title,
// and button actions (can use flag)
class ItemEditingView extends StatefulWidget {
  Item item;

  ItemEditingView({@required this.item});

  @override
  _ItemEditingViewState createState() => _ItemEditingViewState(item);
}

class _ItemEditingViewState extends State<ItemEditingView> {
  _ItemEditingViewState(Item item) {
    this.item = item;
    itemNameController = TextEditingController(text: item.name);
    quantityController = TextEditingController(text: item.quantity);
    expiryController =
        TextEditingController(text: getDaysLeft(item.expiryDate));
    descriptionController = TextEditingController(text: item.description);
  }

  Item item;
  File _photo;

  TextEditingController itemNameController;
  TextEditingController quantityController;
  TextEditingController expiryController;
  TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return BaseView<ItemEditingModel>(
      builder: (
        BuildContext context,
        ItemEditingModel model,
        Widget child,
      ) =>
          WillPopScope(
            // Overwriting the pop function of the page, so it won't jump back to
            // the main page immediately
            onWillPop: _onWillPop,
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Edit Item', style: TextStyle(fontSize: 24)),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: _photo == null
                          ? FadeInImage.assetNetwork(
                              placeholder: 'assets/camera.png',
                              image: '$SPACES_BASE_URL/${item.photo}',
                            )
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
                    _inputTextTile('Quantity (eg. 1/2 pint, 5 pieces)',
                        quantityController),
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
                          ? const Text('Update Item')
                          : const Text('Updating...'),
                      onPressed: model.state == ViewState.Idle
                          ? () async {
                              await model.edit(
                                itemNameController.text,
                                quantityController.text,
                                expiryController.text,
                                descriptionController.text,
                                _photo,
                                item.photo,
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
                    'Are you sure you don\'t want to update your item?'),
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

  String getDaysLeft(DateTime expiryDate) {
    return expiryDate.difference(DateTime.now()).inDays.toString();
  }
}
