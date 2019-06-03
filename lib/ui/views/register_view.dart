import 'package:flutter/material.dart';
import 'package:frontend/core/view_models/register_model.dart';
import 'package:frontend/core/view_models/view_state.dart';

import 'base_view.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();

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
                    _inputTextTile('Full name', _fullNameController),
                    _inputTextTile('Username', _usernameController),
                    _inputTextTile('Password', _passwordController),
                    _inputTextTile('Location (e.g. block/room number)',
                        _locationController),
                    _inputTextTile('Phone number', _phoneNumController),
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
                      final bool loginSuccess = await model.register(
                          _fullNameController.text,
                          _usernameController.text,
                          _passwordController.text,
                          _locationController.text,
                          _phoneNumController.text,
                      );

                      if (loginSuccess) {
                        Navigator.pushReplacementNamed(context, '/items');
                      }
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
