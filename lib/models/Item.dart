import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';

class Item {
  final int id;
  final String name;
  final String photo;
  final int quantity;
  final DateTime expiryTime;
  final String description;
  final String userLocation;
  final String userPhoneNumber;
  final String userName;

  Item({this.id, this.name, this.photo, this.quantity, this.expiryTime, this.description,
      this.userLocation, this.userPhoneNumber, this.userName});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      photo: json['photo'],
      quantity: json['quantity'],
      expiryTime: json['expiry_time'],
      description: json['description'],
      userLocation: json['user']['location'],
      userPhoneNumber: json['user']['phone_no'],
      userName: json['user']['name']
    );
  }

  Future<Item> fetchItem(int id) async {
    final response = await http.get(BASE_URL + 'items/' + id.toString());

    if (response.statusCode == 200) {
      return Item.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load item id {id}' + id.toString());
    }
  }
}