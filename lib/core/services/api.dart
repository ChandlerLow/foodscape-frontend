import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:frontend/core/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/item.dart';

class Api {
  static const String endpoint = 'https://foodscape.iamkelv.in';

  Client client = http.Client();
  Future<List<Item>> getUserItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final Response response = await client.get(
      // TODO(Viet): include /user
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

    final List<dynamic> itemsJson =
    json.decode(response.body)['all_categories'];
    return itemsJson
        .map((dynamic itemJson) => Item.fromJson(itemJson))
        .toList();
  }

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

    final List<dynamic> itemsJson =
        json.decode(response.body)['all_categories'];
    return itemsJson
        .map((dynamic itemJson) => Item.fromJson(itemJson))
        .toList();
  }

  Future<bool> createItem(
    String itemName,
    String quantity,
    String expiry,
    String description,
    File photo,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Upload image
    String filename;
    if (photo != null) {
      final Uri uri = Uri.parse('$endpoint/photos/upload');
      final MultipartRequest request = http.MultipartRequest('POST', uri);
      request.headers['authorization'] =
          'Bearer ${prefs.getString('user.token')}';
      final MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'upload',
        photo.path,
        contentType: MediaType('image', 'jpeg'),
      );
      log(photo.path);
      request.files.add(multipartFile);

      final Response imageResponse =
          await Response.fromStream(await request.send());

      if (imageResponse.statusCode != HttpStatus.created) {
        throw Exception('Failed to upload image');
      }

      filename = json.decode(imageResponse.body)['filename'];
    }

    // Create item
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
        'photo': photo == null ? '' : filename,
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create items');
    }

    return true;
  }

  // TODO(x): refactor it with createItem -> remove duplication
  // Only change is using put instead of post:
  // final Response response = await client.put(...)
  Future<bool> editItem(
    String itemName,
    String quantity,
    String expiry,
    String description,
    File photo,
    String originalPhoto,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Upload image
    String filename;
    if (photo != null) {
      final Uri uri = Uri.parse('$endpoint/photos/upload');
      final MultipartRequest request = http.MultipartRequest('POST', uri);
      request.headers['authorization'] =
      'Bearer ${prefs.getString('user.token')}';
      final MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'upload',
        photo.path,
        contentType: MediaType('image', 'jpeg'),
      );
      log(photo.path);
      request.files.add(multipartFile);

      final Response imageResponse =
      await Response.fromStream(await request.send());

      if (imageResponse.statusCode != HttpStatus.created) {
        throw Exception('Failed to upload image');
      }

      filename = json.decode(imageResponse.body)['filename'];
    } else {
      filename = originalPhoto;
    }

    // Create item
    final Response response = await client.put(
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
        'photo': filename,
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create items');
    }

    return true;
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

  Future<User> registerUser(
    String username,
    String password,
    String name,
    String location,
    String phoneNo,
  ) async {
    final Response response = await client.post(
      '$endpoint/auth/register',
      body: {
        'username': username,
        'password': password,
        'name': name,
        'location': location,
        'phone_no': phoneNo,
      },
    );

    if (response.statusCode != 200) {
      return null;
    }

    return User.fromJson(json.decode(response.body));
  }
}
