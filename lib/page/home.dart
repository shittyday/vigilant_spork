import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final cookieManager = WebViewCookieManager();
  bool loading = true;
  @override
  void initState() {
    const params = PlatformWebViewControllerCreationParams();
    _controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) {},
        onPageFinished: (url) {
          setState(() {
            loading = false;
          });
        },
        onPageStarted: (url) async {
          cookieManager.setCookie(WebViewCookie(
              name: 'expires',
              value: DateFormat().format(DateTime.now().toUtc()),
              domain: Uri.parse(url).host));
          cookieManager.setCookie(WebViewCookie(
              name: 'path',
              value: DateFormat().format(DateTime.now().toUtc()),
              domain: Uri.parse(url).path));
          setState(() {
            loading = true;
          });
        },
        onWebResourceError: (error) {
          setState(() {
            loading = false;
          });
        },
      ))
      ..loadRequest(Uri.parse(url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Запрет на назад
    return WillPopScope(
        child: Stack(
          children: [
            Positioned.fill(
                child: WebViewWidget(
              controller: _controller,
            )),
            if (loading)
              const Center(
                child: CircularProgressIndicator(),
              )
          ],
        ),
        onWillPop: () async {
          _controller.goBack();
          return false;
        });
  }
}
