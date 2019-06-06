import 'dart:async';

import 'package:frontend/core/models/user.dart';
import 'package:frontend/core/services/api.dart';
import 'package:frontend/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  final Api _api = locator<Api>();

  StreamController<User> userController = StreamController<User>();

  Future<bool> login(String username, String password) async {
    final User fetchedUser = await _api.authUser(username, password);
    final bool hasUser = fetchedUser != null;

    if (hasUser) {
      await storeUserInPreferences(fetchedUser);
      userController.add(fetchedUser);
    }

    return hasUser;
  }

  Future<bool> register(
    String name,
    String username,
    String password,
    String location,
    String phoneNum,
  ) async {
    final User newUser = await _api.registerUser(username, password, name, location, phoneNum);
    final bool hasUser = newUser != null;

    if (hasUser) {
      await storeUserInPreferences(newUser);
      userController.add(newUser);
    }

    return hasUser;
  }

  Future<void> storeUserInPreferences(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user.id', user.id);
    await prefs.setString('user.name', user.name);
    await prefs.setString('user.location', user.location);
    await prefs.setString('user.phoneNumber', user.phoneNumber);
    await prefs.setString('user.token', user.token);
  }

  Future<bool> fetchUserFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final User user = User(
      id: prefs.getInt('user.id'),
      name: prefs.getString('user.name'),
      location: prefs.getString('user.location'),
      phoneNumber: prefs.getString('user.phoneNumber'),
      token: prefs.getString('user.token'),
    );

    if (user.token == null || user.token == '') {
      return false;
    }

    userController.add(user);
    return true;
  }
}
