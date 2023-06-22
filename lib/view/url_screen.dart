import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_shortener/controller/api_call.dart';
import 'package:url_shortener/controller/provider.dart';

class UrlScreen extends StatelessWidget {
  const UrlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "URL SHORTENER",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Consumer<UrlProvider>(builder: (context, urlClass, _) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                controller: urlClass.urlController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter the url here'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      const CircularProgressIndicator(
                        strokeWidth: 2.0,
                      );
                      await urlShortener(urlClass.urlController.text)
                          .then((value) {
                        if (value == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Url is invalid",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          Navigator.of(context).pop();
                          return;
                        }
                        urlClass.resultController.text = value.url as String;
                      });
                    },
                    icon: const Icon(Icons.settings_suggest_outlined),
                    label: const Text("Generate"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      urlClass.urlController.clear();
                      urlClass.resultController.clear();
                    },
                    icon: const Icon(Icons.clear),
                    label: const Text("Clear"),
                  ),
                ],
              ),
              TextFormField(
                controller: urlClass.resultController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'The result will be show here',
                    suffixIcon: IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                            text: urlClass.resultController.text));
                      },
                      icon: const Icon(Icons.copy),
                    )),
              ),
            ],
          ),
        );
      }),
    );
  }
}
