import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/view_models/register_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/ui/shared/app_colors.dart' as app_colors;
import 'package:frontend/ui/shared/ui_helpers.dart';

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
    final MediaQueryData queryData = MediaQuery.of(context);
    return BaseView<RegisterModel>(
      builder: (BuildContext context, RegisterModel model, Widget child) =>
          Scaffold(
            backgroundColor: app_colors.backgroundColorPink,
            body: SingleChildScrollView(
              padding: EdgeInsets.only(top: queryData.size.height * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: queryData.size.width * 0.6,
                    height: 200,
                    child: Image.asset('assets/doughnut.png'),
                    alignment: Alignment.center,
                  ),
                  Container(
                    child: const Text(
                      'FoodScape',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  UIHelper.verticalSpaceMedium(),
                  _inputTextTile('Full name', _fullNameController),
                  _inputTextTile('Username', _usernameController),
                  _inputTextTile('Password', _passwordController),
                  _inputTextTile(
                    'Location (e.g. block/room number)',
                    _locationController,
                  ),
                  _inputTextTile('Phone number', _phoneNumController),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: FloatingActionButton.extended(
                      heroTag: null,
                      backgroundColor: Colors.white,
                      elevation: 0,
                      label: Text(
                        model.state == ViewState.Idle
                            ? 'Register'
                            : 'Registering...',
                        style: const TextStyle(
                          color: app_colors.backgroundColorPink,
                        ),
                      ),
                      onPressed: model.state == ViewState.Idle
                          ? () async {
                              if (_fullNameController.text == '' ||
                                  _usernameController.text == '' ||
                                  _passwordController.text == '' ||
                                  _locationController.text == '' ||
                                  _phoneNumController.text == '') {
                                return showDialog<dynamic>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: const Text('Invalid Input'),
                                            content: const Text(
                                              'Make sure no fields are empty and try again!',
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: const Text('OK'),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                              ),
                                            ],
                                          ),
                                    ) ??
                                    false;
                              }

                              final bool loginSuccess = await model.register(
                                _fullNameController.text,
                                _usernameController.text,
                                _passwordController.text,
                                _locationController.text,
                                _phoneNumController.text,
                              );

                              if (loginSuccess) {
                                Navigator.pushReplacementNamed(context, '/');
                              }
                            }
                          : null,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'Have an account?',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _inputTextTile(String hintText, TextEditingController controller) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        height: 55.0,
        width: MediaQuery.of(context).size.width * 0.85,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black12,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(90.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 5.0,
          ),
          child: TextField(
            decoration: InputDecoration.collapsed(
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 16),
            ),
            controller: controller,
          ),
        ));
  }
}
