import 'dart:convert';

import 'package:crypto_app/models/currency.dart';
import 'package:http/http.dart' as http;

class CryptoApi {
  final String _key = 'fa87ab3d15b25533cfacec3b07e35737b9545bc5';
  Future<List<Currency>> getCurrencies() async {
    final url =
        'https://api.nomics.com/v1/currencies/ticker?key=$_key&interval=1d,30d&convert=EUR&per-page=100&page=1';
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body) as List;

    return body.map((item) => Currency.fromJson(item)).toList();
  }
}
