import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_shortener/model/url_model.dart';

Future<UrlModel?> urlShortener(String link) async {
  try {
    final url =
        Uri.parse('https://url-shortener-service.p.rapidapi.com/shorten');
    final headers = {
      'content-type': 'application/x-www-form-urlencoded',
      'X-RapidAPI-Key': 'b6f5ed5fa0msh7b6952959da336ep173d2ejsne90582df0c9e',
      'X-RapidAPI-Host': 'url-shortener-service.p.rapidapi.com'
    };

    final response =
        await http.post(url, headers: headers, body: {'url': link});

    if (response.statusCode == 200) {
      print(response.body);
      var json = jsonDecode(response.body);
      return UrlModel.fromJson(json);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } on Exception catch (e) {
    print(e.toString());
    return null;
  }
  return null;
}
