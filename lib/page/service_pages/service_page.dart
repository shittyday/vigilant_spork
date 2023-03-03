import 'package:flutter/material.dart';
import 'package:vigilant_spork/api/news/repository/repository.dart';
import 'package:vigilant_spork/page/service_pages/quiz/service_quiz_page.dart';
import 'package:vigilant_spork/utils/internet_check.dart';

import 'news/service_news_page.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  bool loading = true;

  bool connection = false;

  static const _circularProgressKey = ValueKey('_circularProgressKey');
  static const _serviceNewsKey = ValueKey('_serviceNewsKey');
  static const _serviceQuizKey = ValueKey('_serviceQuizKey');

  @override
  void initState() {
    super.initState();
    checkInternet.then((value) {
      if (!mounted) return;
      setState(() {
        connection = value;
        loading = false;
      });
    }, onError: (e) {
      if (!mounted) return;
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            key: _circularProgressKey,
            child: CircularProgressIndicator(),
          )
        : connection
            ? const Material(
                child: ServiceNewsPage(
                  key: _serviceNewsKey,
                  repository: Repository(),
                ),
              )
            : const ServiceQuizPage(
                key: _serviceQuizKey,
              );
  }
}
