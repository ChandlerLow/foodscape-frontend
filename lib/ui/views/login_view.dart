import 'package:flutter/material.dart';
import 'package:frontend/core/view_models/login_model.dart';
import 'package:frontend/core/view_models/view_state.dart';

import 'base_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (BuildContext context, LoginModel model, Widget child) =>
          Scaffold(
            body: model.state == ViewState.Idle
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _textFieldWidget(
                          'username', context, _usernameController, model),
                      _textFieldWidget(
                          'password', context, _passwordController, model),
                      FlatButton(
                          color: Colors.grey,
                          child: const Text(
                            'Sign In',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () async {
                            final bool loginSuccess = await model.login(
                              _usernameController.text,
                              _passwordController.text,
                            );

                            if (loginSuccess) {
                              Navigator.pushReplacementNamed(context, '/items');
                            }
                          }),
                    ],
                  )
                : Center(child: const CircularProgressIndicator()),
          ),
    );
  }

  Widget _textFieldWidget(
    String hintText,
    BuildContext context,
    TextEditingController controller,
    LoginModel model,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      height: 50.0,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: model.errorMessage == null ? Colors.white : Colors.redAccent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        decoration: InputDecoration.collapsed(hintText: hintText),
        controller: controller,
      ),
    );
  }
}
