import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/core/models/categories.dart';
import 'package:frontend/core/models/category.dart';
import 'package:frontend/core/models/item.dart';
import 'package:frontend/core/view_models/item_editing_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/ui/views/base_view.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';

class ItemEditingView extends StatefulWidget {
  const ItemEditingView({@required this.item});

  final Item item;

  @override
  _ItemEditingViewState createState() => _ItemEditingViewState(item);
}

class _ItemEditingViewState extends State<ItemEditingView> {
  _ItemEditingViewState(this.item) {
    itemNameController = TextEditingController(text: item.name);
    quantityController = TextEditingController(text: item.quantity);
    expiryController =
        TextEditingController(text: getDaysLeft(item.expiryDate));
    descriptionController = TextEditingController(text: item.description);
    category = defaultCategories[item.categoryId];
    id = item.id;
  }

  int id;
  Item item;
  File _photo;
  Category category;

  TextEditingController itemNameController;
  TextEditingController quantityController;
  TextEditingController expiryController;
  TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
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
                    _inputTextTile(
                      'Days remaining',
                      expiryController,
                      textInputType: TextInputType.number,
                    ),
                    _inputTextTile('Description', descriptionController),
                    _dropdownCategories(),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                    ),
                    FloatingActionButton.extended(
                      heroTag: 'main-fab',
                      backgroundColor: Colors.grey,
                      elevation: 2.0,
                      label: model.state == ViewState.Idle
                          ? const Text('Update Item')
                          : const Text('Updating...'),
                      onPressed: model.state == ViewState.Idle
                          ? () async {
                              await model.edit(
                                item,
                                itemNameController.text,
                                quantityController.text,
                                expiryController.text,
                                descriptionController.text,
                                _photo,
                              );
                              Navigator.of(context).pop(true);
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  // Generating function for tiles
  ListTile _inputTextTile(String hintText, TextEditingController controller,
      {TextInputType textInputType}) {
    return ListTile(
      title: TextField(
        decoration: InputDecoration(
          hintText: hintText,
        ),
        controller: controller,
        keyboardType: textInputType,
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

  Widget _dropdownCategories() {
    final List<Category> categories = defaultCategories.values.toList();
    return Container(
      alignment: Alignment.center,
      width: 300,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<Category>(
            hint: Text(category.name),
            value: category,
            onChanged: (Category newCategory) {
              setState(() {
                category = newCategory;
              });
            },
            items: categories.map((Category category) {
              return DropdownMenuItem<Category>(
                value: category,
                child: Text(
                  category.name,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
