import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/models/categories.dart';
import 'package:frontend/core/models/category.dart';
import 'package:frontend/core/view_models/item_creation_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/ui/shared/app_colors.dart';
import 'package:frontend/ui/shared/ui_helpers.dart';
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
  Category category = defaultCategories[1];

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
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                backgroundColor: backgroundColorPink,
              ),
              backgroundColor: backgroundColor,
              body: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      UIHelper.verticalSpaceSmall(),
                      const Center(
                        child: Text(
                          'Let\'s get an item added.',
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      UIHelper.verticalSpaceSmall(),
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
                                        ? Container(
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
                                          )
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
                          ],
                        ),
                      ),
                      UIHelper.verticalSpaceLarge(),
                      UIHelper.verticalSpaceMedium(),
                    ],
                  ),
                ),
              ),
              // The button submits the item and returns to the home page
              floatingActionButton: showFab
                  ? FloatingActionButton.extended(
                      heroTag: 'main-fab',
                      backgroundColor: backgroundColorPink,
                      elevation: 2.0,
                      label: model.state == ViewState.Idle
                          ? (model.isCreated
                              ? const Text('Submitted!')
                              : const Text('Submit Item'))
                          : const Text('Submitting...'),
                      onPressed:
                          model.state == ViewState.Idle && !model.isCreated
                              ? () async {
                                  await model.create(
                                    itemNameController.text,
                                    quantityController.text,
                                    expiryController.text,
                                    descriptionController.text,
                                    _photo,
                                    category.id,
                                  );
                                  await Future<Duration>.delayed(
                                      Duration(seconds: 1));
                                  Navigator.of(context)
                                      .pushReplacementNamed('/user/items');
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
    if (itemNameController.text == '' &&
        quantityController.text == '' &&
        expiryController.text == '' &&
        descriptionController.text == '' &&
        _photo == null) {
      return Future<bool>.value(true);
    }

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
    final File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        _photo = img;
      });
    }
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
