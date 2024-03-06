import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewSecreen extends StatefulWidget {
  const WebViewSecreen({super.key, required this.controller});

  final WebViewController controller;

  @override
  State<WebViewSecreen> createState() => _WebViewSecreenState();
}

class _WebViewSecreenState extends State<WebViewSecreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(
          controller: widget.controller,
        ),
      ),
    );
  }
}
