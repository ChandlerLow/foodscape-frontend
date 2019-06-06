import 'package:shared_preferences/shared_preferences.dart';

class User {
  User({this.id, this.name, this.location, this.phoneNumber, this.token});

  User.initial()
      : id = 0,
        name = '',
        location = '',
        phoneNumber = '',
        token = '';

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        location: json['location'],
        phoneNumber: json['phone_no'],
        token: json['token']);
  }

  bool isLoggedIn() {
    return token != '';
  }

  Future<void> setLoggedOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user.token');
    token = '';
  }

  final int id;
  final String name;
  final String location;
  final String phoneNumber;
  String token;
}
