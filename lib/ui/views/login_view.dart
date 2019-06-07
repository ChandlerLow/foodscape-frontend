import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/core/view_models/login_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/ui/shared/app_colors.dart' as app_colors;
import 'package:frontend/ui/shared/ui_helpers.dart';

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
    final MediaQueryData queryData = MediaQuery.of(context);
    return BaseView<LoginModel>(
      builder: (BuildContext context, LoginModel model, Widget child) =>
          Scaffold(
            backgroundColor: app_colors.backgroundColorPink,
            //backgroundColor: Color.fromARGB(255, 233, 197, 29),
            body: model.state == ViewState.Idle
                ? SingleChildScrollView(
                    padding: EdgeInsets.only(top: queryData.size.height * 0.13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: queryData.size.width * 0.8,
                          height: 200,
                          child: Image.asset('assets/doughnut.png'),
                          alignment: Alignment.center,
                        ),
                        UIHelper.verticalSpaceMedium(),
                        Container(
                          child: const Text(
                            'FoodScape',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        UIHelper.verticalSpaceMedium(),
                        _textFieldWidget(
                          Icons.person_outline,
                          'username',
                          context,
                          _usernameController,
                          model,
                        ),
                        _textFieldWidget(
                          Icons.lock_open,
                          'password',
                          context,
                          _passwordController,
                          model,
                          hidden: true,
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: FloatingActionButton.extended(
                            heroTag: null,
                            backgroundColor: Colors.white,
                            elevation: 0,
                            label: Text(
                              model.state == ViewState.Idle
                                  ? 'Sign In' : 'Signing In...',
                              style: const TextStyle(
                                color: app_colors.backgroundColorPink,
                              ),
                            ),
                            onPressed: () async {
                              final bool loginSuccess = await model.login(
                                _usernameController.text,
                                _passwordController.text,
                              );

                              if (loginSuccess) {
                                Navigator.pushReplacementNamed(context, '/');
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/register');
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                "Don't Have An Account?",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ))
                : Center(child: const CircularProgressIndicator()),
          ),
    );
  }

  Widget _textFieldWidget(IconData leadingIcon, String hintText,
      BuildContext context, TextEditingController controller, LoginModel model,
      {bool hidden}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      height: 50.0,
      width: MediaQuery.of(context).size.width * 0.85,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: model.errorMessage == null ? Colors.white : Colors.black12,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(90.0),
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            child: Icon(
              leadingIcon,
              color: Colors.grey,
            ),
          ),
          Container(
            height: 30.0,
            width: 1.0,
            color: Colors.grey.withOpacity(0.5),
            margin: const EdgeInsets.only(left: 5.0, right: 15.0),
          ),
          Expanded(
            child: TextField(
              obscureText: hidden != null,
              decoration: InputDecoration.collapsed(
                hintText: hintText,
                hintStyle: const TextStyle(fontSize: 20),
              ),
              controller: controller,
              textCapitalization: TextCapitalization.none,
            ),
          )
        ],
      ),
    );
  }
}
