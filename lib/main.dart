import 'package:flutter/material.dart';
import 'package:frontend/core/services/authentication_service.dart';
import 'package:frontend/locator.dart';
import 'package:provider/provider.dart';

import 'core/models/user.dart';
import 'ui/router.dart';

void main() async {
  setupLocator();

  final bool hasUser =
      await locator<AuthenticationService>().fetchUserFromPreferences();

  runApp(
    StreamProvider<User>(
      initialData: User.initial(),
      builder: (BuildContext context) =>
          locator<AuthenticationService>().userController,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FoodScape',
        theme: ThemeData(
          primaryColor: Colors.grey,
        ),
        initialRoute: hasUser ? '/items' : '/login',
        onGenerateRoute: Router.generateRoute,
      ),
    ),
  );
}
