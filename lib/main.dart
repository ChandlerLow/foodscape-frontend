import 'package:flutter/material.dart';
import 'package:frontend/core/models/categories.dart';
import 'package:frontend/core/services/authentication_service.dart';
import 'package:frontend/locator.dart';
import 'package:provider/provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'core/models/user.dart';
import 'ui/router.dart';

FirebaseAnalytics analytics = FirebaseAnalytics();

// ignore: avoid_void_async
void main() async {
  setupLocator();

  // Set up authenticated user if one exists
  final bool hasUser =
      await locator<AuthenticationService>().fetchUserFromPreferences();
  await locator<UserCategories>().populateUserSelections();
  analytics.logEvent(name: 'running the app');
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
      navigatorObservers: <NavigatorObserver>[
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      initialRoute: hasUser ? '/' : '/login',
      onGenerateRoute: Router.generateRoute,
    ),
  ));
}
