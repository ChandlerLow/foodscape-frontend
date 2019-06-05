import 'package:flutter/material.dart';
import 'package:frontend/core/models/categories.dart';
import 'package:frontend/core/services/authentication_service.dart';
import 'package:frontend/locator.dart';
import 'package:provider/provider.dart';

import 'core/models/user.dart';
import 'ui/router.dart';

void main() async {
  setupLocator();

  // Set up authenticated user if one exists
  final bool hasUser =
      await locator<AuthenticationService>().fetchUserFromPreferences();
  await locator<UserCategories>().populateUserSelections();

  runApp(StreamProvider<User>(
    initialData: User.initial(),
    builder: (BuildContext context) =>
        locator<AuthenticationService>().userController,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FoodScape',
      theme: ThemeData(
        primaryColor: Colors.grey,
      ),
      initialRoute: hasUser ? '/' : '/login',
      onGenerateRoute: Router.generateRoute,
    ),
  ));
}
