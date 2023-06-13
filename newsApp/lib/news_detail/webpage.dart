import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPage extends StatefulWidget {
  final String newsUrl;
  WebPage({required this.newsUrl});

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  late String finalurl;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.toString().contains("http://")) {
      finalurl = widget.newsUrl.toString().replaceAll("http://", "https://");
    } else {
      finalurl = widget.newsUrl;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          "QuickNEWS",
          style: TextStyle(color: Theme.of(context).iconTheme.color),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Theme.of(context).iconTheme.color),
            onPressed: () => Navigator.of(context).pop()),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: WebviewScaffold(
        url: finalurl,
      ),
    );
  }
}
