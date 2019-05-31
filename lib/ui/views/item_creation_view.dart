import 'package:flutter/material.dart';
import 'package:frontend/core/view_models/item_creation_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/ui/views/base_view.dart';

class ItemCreationView extends StatefulWidget {
  @override
  _ItemCreationViewState createState() => _ItemCreationViewState();
}

class _ItemCreationViewState extends State<ItemCreationView> {
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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
//            onWillPop: showDialog<dynamic>(
//                  context: context,
//                  builder: (BuildContext context) => AlertDialog(
//                        title: const Text('Deleting Item Addition'),
//                        content: const Text('Are you sure?'),
//                        actions: <Widget>[
//                          FlatButton(
//                            onPressed: () => Navigator.of(context).pop(false),
//                            child: const Text('No'),
//                          ),
//                          FlatButton(
//                            onPressed: () => Navigator.of(context).pop(true),
//                            child: const Text('Yes'),
//                          )
//                        ],
//                      ),
//                ) ??
//                false,
            child: Scaffold(
              resizeToAvoidBottomPadding: false,
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Add Item', style: TextStyle(fontSize: 24)),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    // TODO(Viet): button navigates to a new page to take the photo
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage('assets/camera.png'),
                        ),
                      ),
                      width: 270,
                      height: 250,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(0),
                    ),
                    FloatingActionButton.extended(
                      heroTag: null,
                      backgroundColor: Colors.grey,
                      onPressed: () => () async {},
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
                      heroTag: null,
                      backgroundColor: Colors.grey,
                      elevation: 2.0,
                      label: model.state == ViewState.Idle
                          ? const Text('Submit Item')
                          : const Text('Submitting...'),
                      onPressed: model.state == ViewState.Idle
                          ? () async {
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
}
