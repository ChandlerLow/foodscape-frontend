import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/item.dart';

class Api {
  static const String endpoint = 'https://foodscape.iamkelv.in';

  Client client = http.Client();

  Future<List<Item>> getItems() async {
    final Response response = await client.get('$endpoint/items');
    if (response.statusCode == 200) {
      final List<dynamic> itemsJson = json.decode(response.body);
      return itemsJson
          .map((dynamic itemJson) => Item.fromJson(itemJson))
          .toList();
    } else {
      throw Exception('Failed to load items');
    }
  }
}
