import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_shortener/controller/api_call.dart';
import 'package:url_shortener/controller/provider.dart';

class UrlScreen extends StatelessWidget {
  const UrlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FocusNode _focusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
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
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Enter the url here',
                    suffixIcon: IconButton(
                        onPressed: () async {
                          var clipBoradData =
                              await Clipboard.getData(Clipboard.kTextPlain);
                          print(clipBoradData!.text);
                          urlClass.urlController.text = clipBoradData.text!;
                        },
                        icon: const Icon(Icons.paste))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) => const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  backgroundColor: Colors.amber,
                                ),
                              ));

                      await urlShortener(urlClass.urlController.text)
                          .then((value) {
                        // _focusNode.unfocus();
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
                        Navigator.of(context).pop();
                        urlClass.resultController.text = value.url as String;
                      });
                      _focusNode.unfocus();
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
                readOnly: true,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'The shortened URL will be show here',
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
