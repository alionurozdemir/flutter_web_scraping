import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InstaView extends StatefulWidget {
  const InstaView({Key? key}) : super(key: key);

  @override
  State<InstaView> createState() => _InstaViewState();
}

class _InstaViewState extends State<InstaView> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _onListCookies(WebViewController controller, BuildContext context) async {
    final String cookies = await controller.runJavascriptReturningResult('document.cookie');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Cookies:'),
          _getCookieList(cookies),
        ],
      ),
    ));
  }

  Widget _getCookieList(String cookies) {
    if (cookies == null || cookies == '""') {
      return Container();
    }
    final List<String> cookieList = cookies.split(';');
    final Iterable<Text> cookieWidgets = cookieList.map((String cookie) => Text(cookie));
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: cookieWidgets.toList(),
    );
  }

  Future<void> _onShowUserAgent(WebViewController controller, BuildContext context) async {
    // Send a message with the user agent string to the Toaster JavaScript channel we registered
    // with the WebView.
    await controller.runJavascript(' alert("Hello! I am an alert box!!");');
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://www.instagram.com/nasa',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
