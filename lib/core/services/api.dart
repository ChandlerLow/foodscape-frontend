import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:frontend/core/models/categories.dart';
import 'package:frontend/core/models/category.dart';
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
      '$endpoint/items/user',
      headers: <String, String>{
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

  Future<Map<int, List<Item>>> getItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final Response response = await client.get(
      '$endpoint/items',
      headers: <String, String>{
        HttpHeaders.authorizationHeader:
            'Bearer ${prefs.getString('user.token')}',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to load items - ${response.statusCode} - '
          '${response.body} - ${prefs.getString('user.token')}');
    }

    final Map<int, List<Item>> categories = <int, List<Item>>{};
    for (Category category in defaultCategories.values) {
      final List<dynamic> itemsJson =
          json.decode(response.body)[category.id.toString()];
      categories[category.id] =
          itemsJson.map((dynamic itemJson) => Item.fromJson(itemJson)).toList();
    }

    return categories;
  }

  Future<bool> createItem(
    String itemName,
    String quantity,
    String expiry,
    String description,
    File photo,
    int categoryId,
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
      headers: <String, String>{
        HttpHeaders.authorizationHeader:
            'Bearer ${prefs.getString('user.token')}',
      },
      body: <String, dynamic>{
        'name': itemName,
        'quantity': quantity,
        'expiry_date': expiry,
        'description': description,
        'photo': photo == null ? '' : filename,
        'category_id': categoryId.toString(),
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create items');
    }

    return true;
  }

  Future<bool> editItem(
    Item item,
    String newName,
    String newQuantity,
    String newExpiry,
    String newDescription,
    File newPhoto,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Upload image (optional)
    String filename;
    if (newPhoto != null) {
      final Uri uri = Uri.parse('$endpoint/photos/upload');
      final MultipartRequest request = http.MultipartRequest('POST', uri);
      request.headers['authorization'] =
          'Bearer ${prefs.getString('user.token')}';
      final MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'upload',
        newPhoto.path,
        contentType: MediaType('image', 'jpeg'),
      );
      log(newPhoto.path);
      request.files.add(multipartFile);

      final Response imageResponse =
          await Response.fromStream(await request.send());

      if (imageResponse.statusCode != HttpStatus.created) {
        throw Exception('Failed to upload image');
      }

      filename = json.decode(imageResponse.body)['filename'];
    } else {
      filename = item.photo == null ? '' : item.photo;
    }

    // Create item
    final Response response = await client.put(
      '$endpoint/items/${item.id}',
      headers: <String, String>{
        HttpHeaders.authorizationHeader:
            'Bearer ${prefs.getString('user.token')}',
      },
      body: <String, dynamic>{
        'name': newName,
        'quantity': newQuantity,
        'expiry_date': newExpiry,
        'description': newDescription,
        'photo': filename,
        'category_id': item.id.toString(),
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create items');
    }

    return true;
  }

  Future<bool> setCollected(bool isCollected, int itemId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final Response response = await client.post(
      '$endpoint/items/$itemId/collected',
      headers: {
        HttpHeaders.authorizationHeader:
          'Bearer ${prefs.getString('user.token')}',
      },
      body: {
        'is_collected': isCollected.toString(),
      },
    );
    if(response.statusCode != 200) {
      throw Exception('Failed to set collected');
    }

    return true;
  }

  Future<bool> deleteItem(int itemId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final Response response = await client.delete(
      '$endpoint/items/$itemId',
      headers: {
        HttpHeaders.authorizationHeader:
          'Bearer ${prefs.getString('user.token')}',
      },
    );

    if(response.statusCode != 200) {
      throw Exception('Could not delete item');
    }

    return true;
  }

  Future<User> authUser(String username, String password) async {
    final Response response = await client.post(
      '$endpoint/auth/login',
      body: <String, String>{
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
      body: <String, dynamic>{
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
