import 'package:flutter/material.dart';
import 'package:frontend/core/view_models/register_model.dart';
import 'package:frontend/core/view_models/view_state.dart';

import 'base_view.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return BaseView<RegisterModel>(
      builder: (BuildContext context, RegisterModel model, Widget child) =>
          Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title:
                  const Text('Register User', style: TextStyle(fontSize: 24)),
            ),
            body: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    _inputTextTile('Full name', fullNameController),
                    _inputTextTile('Username', usernameController),
                    _inputTextTile('Password', passwordController),
                    _inputTextTile('Location (e.g. block/room number)',
                        locationController),
                    _inputTextTile('Phone number', phoneNumController),
                  ],
                )),

            // The button submits the item and returns to the home page
            floatingActionButton: showFab
                ? FloatingActionButton.extended(
                    heroTag: null,
                    backgroundColor: Colors.grey,
                    elevation: 2.0,
                    label: model.state == ViewState.Idle
                        ? const Text('Register')
                        : const Text('Registering...'),
                    onPressed: model.state == ViewState.Idle
                        ? () async {
                            await model.register();
                            Navigator.pushNamed(context, '/items');
                          }
                        : null,
                  )
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          ),
    );
  }

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
