import 'package:flutter/material.dart';
import 'package:frontend/core/view_models/login_model.dart';
import 'package:frontend/core/view_models/view_state.dart';

import 'base_view.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (
        BuildContext context,
        LoginModel model,
        Widget child
        )  =>
        Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              makeTextField('username', context, _usernameController),
              makeTextField('password', context, _passwordController),
              model.state == ViewState.Busy
                ? CircularProgressIndicator()
                : FlatButton(
                color: Colors.grey,
                child: const Text(
                  'Sign In',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async {
                  var loginSuccess = await model.login(_usernameController.text, _passwordController.text);
                  if(loginSuccess) {
                    Navigator.pushNamed(context, '/items');
                  }
                }),
            ],
          ),
        ),
      );
  }

  Widget makeTextField(String hintText, BuildContext context, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      height: 50.0,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: TextField(
        decoration: InputDecoration.collapsed(hintText: hintText),
        controller: controller),
    );
  }
}