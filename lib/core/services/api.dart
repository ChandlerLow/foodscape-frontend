import 'dart:convert';
import 'dart:io';

import 'package:frontend/core/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/item.dart';

class Api {
  static const String endpoint = 'https://foodscape.iamkelv.in';

  Client client = http.Client();

  Future<List<Item>> getItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final Response response = await client.get(
      '$endpoint/items',
      headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ${prefs.getString('user.token')}',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to load items - ${response.statusCode} - '
          '${response.body} - ${prefs.getString('user.token')}');
    }

    final List<dynamic> itemsJson = json.decode(response.body);
    return itemsJson
        .map((dynamic itemJson) => Item.fromJson(itemJson))
        .toList();
  }

  Future<void> createItem(
    String itemName,
    String quantity,
    String expiry,
    String description,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final Response response = await client.post(
      '$endpoint/items',
      headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ${prefs.getString('user.token')}',
      },
      body: {
        'name': itemName,
        'quantity': quantity,
        'expiry_date': expiry,
        'description': description,
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create items');
    }
  }

  Future<User> authUser(String username, String password) async {
    final Response response = await client.post(
      '$endpoint/auth/login',
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode != 200) {
      return null;
    }

    return User.fromJson(json.decode(response.body));
  }
}
