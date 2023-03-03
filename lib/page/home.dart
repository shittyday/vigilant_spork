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
  double _progress = 0;
  bool loading = true;
  @override
  void initState() {
    const params = PlatformWebViewControllerCreationParams();
    _controller = WebViewController.fromPlatformCreationParams(params)
      ..setBackgroundColor(Colors.white)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) {
          setState(() {
            _progress = progress / 100;
          });
        },
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
              value: Uri.parse(url).path,
              domain: Uri.parse(url).host));
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
              Center(
                child: CircularProgressIndicator(value: _progress),
              )
          ],
        ),
        onWillPop: () async {
          _controller.goBack();
          return false;
        });
  }
}
