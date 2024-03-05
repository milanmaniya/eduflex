import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewSecreen extends StatefulWidget {
  const WebViewSecreen({super.key, required this.url});

  final String url;

  @override
  State<WebViewSecreen> createState() => _WebViewSecreenState();
}

class _WebViewSecreenState extends State<WebViewSecreen> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title: const Text('News'),
        centerTitle: true,
      ),
    );
  }
}
