import 'package:flutter/material.dart';
import 'package:graphics_news/Colors/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Graphics_services extends StatefulWidget {
  @override
  _Graphics_servicesState createState() => _Graphics_servicesState();
}

class _Graphics_servicesState extends State<Graphics_services> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Graphics Services',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: WidgetColors.primaryColor,
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: "https://www.graphic.com.gh/eservices",
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: WidgetColors.primaryColor,
                  ),
                )
              : Stack(),
        ],
      ),
    );
  }
}

//
