import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/core/models/categories.dart';
import 'package:frontend/core/models/category.dart';
import 'package:frontend/core/models/item.dart';
import 'package:frontend/core/view_models/item_editing_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/ui/shared/app_colors.dart' as app_colors;
import 'package:frontend/ui/shared/app_colors.dart';
import 'package:frontend/ui/shared/ui_helpers.dart';
import 'package:frontend/ui/views/base_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

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
    expiryController = TextEditingController(
      text: getDaysLeft(item.expiryDate),
    );
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
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                backgroundColor: app_colors.backgroundColorPink,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 3.0,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          UIHelper.verticalSpaceSmall(),
                          Container(
                            height: 175.0,
                            width: 305.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5.0,
                                  offset: Offset(0, 1),
                                )
                              ],
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                Container(
                                  child: _photo == null
                                      ? (item.photo != null && item.photo != ''
                                          ? Container(
                                              child: Stack(
                                                children: <Widget>[
                                                  Shimmer.fromColors(
                                                    baseColor: Colors.grey[300],
                                                    highlightColor:
                                                        Colors.grey[100],
                                                    child: Container(
                                                      height: 150,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  FadeInImage.assetNetwork(
                                                    placeholder:
                                                        'assets/1x1.png',
                                                    image:
                                                        '$SPACES_BASE_URL/${item.photo}',
                                                    fit: BoxFit.cover,
                                                    height: 150,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                  ),
                                                ],
                                              ),
                                              alignment: Alignment.center,
                                            )
                                          : Container(
                                              child: Icon(
                                                category.icon,
                                                size: 50,
                                                color: Colors.black,
                                              ),
                                              alignment: Alignment.center,
                                              height: 170,
                                              width: 300,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFFABBC5),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ))
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                            _photo,
                                            fit: BoxFit.cover,
                                            height: 170.0,
                                            width: 300.0,
                                          ),
                                        ),
                                  width: 170,
                                  height: 300,
                                  alignment: Alignment.center,
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    child: RawMaterialButton(
                                      constraints: BoxConstraints.tight(
                                        const Size(35, 35),
                                      ),
                                      onPressed: () => _takePhoto(),
                                      child: const Icon(
                                        Icons.camera_alt,
                                        size: 15.0,
                                        color: Colors.white,
                                      ),
                                      shape: CircleBorder(),
                                      elevation: 2.0,
                                      fillColor: backgroundColorPink,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          UIHelper.verticalSpaceSmall(),
                          _inputTextTile(
                            'Item name',
                            itemNameController,
                            textCapitalization: TextCapitalization.words,
                          ),
                          _dropdownCategories(),
                          _inputTextTile(
                            'Quantity (eg. 1/2 pint, 5 pieces)',
                            quantityController,
                            textCapitalization: TextCapitalization.sentences,
                          ),
                          _inputTextTile(
                            'Days remaining',
                            expiryController,
                            keyboardType: TextInputType.number,
                          ),
                          _inputTextTile(
                            'Description',
                            descriptionController,
                            keyboardType: TextInputType.multiline,
                            textCapitalization: TextCapitalization.sentences,
                          ),
                          UIHelper.verticalSpaceSmall(),
                          FloatingActionButton.extended(
                            heroTag: 'main-fab',
                            backgroundColor: app_colors.backgroundColorPink,
                            elevation: 2.0,
                            label: Text(
                              model.state == ViewState.Idle
                                  ? 'Update Item'
                                  : 'Updating...',
                              style: const TextStyle(color: Colors.white),
                            ),
                            onPressed: model.state == ViewState.Idle
                                ? () async {
                                    await model.edit(
                                      item,
                                      itemNameController.text,
                                      quantityController.text,
                                      expiryController.text,
                                      descriptionController.text,
                                      category.id,
                                      _photo,
                                    );
                                    Navigator.of(context).pop(true);
                                  }
                                : null,
                          ),
                          UIHelper.verticalSpaceSmall(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  // Generating function for tiles
  ListTile _inputTextTile(
    String hintText,
    TextEditingController controller, {
    TextInputType keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return ListTile(
      title: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: const Color(0xFF4176F1), width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: const Color(0xFF9FB1CC), width: 1.0),
          ),
        ),
        controller: controller,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        maxLines: keyboardType == TextInputType.multiline ? 5 : 1,
      ),
    );
  }

  Future<bool> _onWillPop() {
    if (itemNameController.text == item.name &&
        quantityController.text == item.quantity &&
        expiryController.text == getDaysLeft(item.expiryDate) &&
        descriptionController.text == item.description) {
      return Future<bool>.value(true);
    }

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
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5.0),
      height: 60.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: const Color(0xFF9FB1CC), width: 1.0),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<Category>(
            hint: const Text('Select a category'),
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
