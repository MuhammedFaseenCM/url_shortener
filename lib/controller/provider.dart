import 'package:flutter/material.dart';

class UrlProvider extends ChangeNotifier {
  TextEditingController urlController = TextEditingController();
  TextEditingController resultController = TextEditingController();

  String get urlString => urlController.text;

  set urlString(String url) {
    urlController.text = url;
  }

  
}
