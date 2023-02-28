import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  final String url;
  const Home({
    super.key,
    required this.url,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final url = widget.url;
  late WebViewController _controller;
  WebViewCookieManager cookieManager = WebViewCookieManager();
  @override
  void initState() {
    super.initState();
    const params = PlatformWebViewControllerCreationParams();
    _controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) {},
        onPageFinished: (url) {},
        onPageStarted: (url) {},
        onWebResourceError: (error) {},
      ))
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    /// Запрет на назад
    return WillPopScope(
        child: WebViewWidget(
          controller: _controller,
        ),
        onWillPop: () async {
          _controller.goBack();
          return false;
        });
  }
}
