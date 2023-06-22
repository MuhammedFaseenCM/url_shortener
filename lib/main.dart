import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_shortener/controller/provider.dart';
import 'package:url_shortener/view/url_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => UrlProvider(),
        child: MaterialApp(
          title: 'Url Shortener',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: const UrlScreen(),
        ));
  }
}
