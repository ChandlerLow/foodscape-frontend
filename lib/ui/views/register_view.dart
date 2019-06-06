import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/view_models/register_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/ui/shared/app_colors.dart' as colorConst;
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
            backgroundColor: colorConst.backgroundColorPink,
            body: SingleChildScrollView(
                padding: EdgeInsets.only(top: queryData.size.height * 0.1),
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
                    _inputTextTile('Location (e.g. block/room number)',
                        _locationController),
                    _inputTextTile('Phone number', _phoneNumController),
                    Container(
                      padding: const EdgeInsets.only(top: 15),
                      child: FloatingActionButton.extended(
                              heroTag: null,
                              backgroundColor: Colors.white,
                              elevation: 2.0,
                              label: Text(
                                model.state == ViewState.Idle
                                    ? 'Register'
                                    : 'Registersing...',
                                style: const TextStyle(
                                    color: colorConst.backgroundColorPink
                                ),
                              ),
                              onPressed: model.state == ViewState.Idle
                                  ? () async {
                                      final bool loginSuccess =
                                          await model.register(
                                        _fullNameController.text,
                                        _usernameController.text,
                                        _passwordController.text,
                                        _locationController.text,
                                        _phoneNumController.text,
                                      );

                                      if (loginSuccess) {
                                        Navigator.pushReplacementNamed(
                                            context, '/');
                                      }
                                    }
                                  : null,
                            ),
                    ),
                    Container(
                        child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/login');
                      },
                      child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            'Have an account?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          )),
                    )),
                  ],
                )),
          ),
    );
  }

  Widget _inputTextTile(String hintText, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      height: 45.0,
      width: MediaQuery.of(context).size.width * 0.80,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.pink,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(90.0),
      ),
      child: TextField(
        decoration: InputDecoration.collapsed(
            hintText: hintText, hintStyle: const TextStyle(fontSize: 16)),
        controller: controller,
      ),
    );
  }
}
