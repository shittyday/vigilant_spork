import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:vigilant_spork/page/service_pages/service_page.dart';
import 'package:vigilant_spork/utils/condition.dart';
import 'package:vigilant_spork/utils/database.dart';
import 'package:vigilant_spork/utils/internet_check.dart';
import 'package:vigilant_spork/utils/page_type.dart';

import 'home.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  PageType? pageType;
  Object? _error;

  String? _url;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    remConf().then((value) {
      boostrap().then((value) {
        if (!mounted) return;
        setState(() {});
      }, onError: (error, stackTrace) {
        _error = error;

        if (!mounted) return;
        setState(() {});
      });
    }, onError: (error, stackTrace) {
      _error = error;

      if (!mounted) return;
      setState(() {});
    });
    super.didChangeDependencies();
  }

  Future<void> remConf() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 5),
      ));
      await remoteConfig.fetchAndActivate();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> boostrap() async {
    final database = Database();
    String? url = await database.url;
    final connection = await checkInternet;
    if (url == null || url.isEmpty) {
      url = FirebaseRemoteConfig.instance.getString('url');
      pageType = await remoteConfigResultType(
        url: url,
        emulatorOrNoSim: await condition,
        database: database,
      );
    } else {
      pageType = connectionResultType(connection);
    }
    _url = url;
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => _caseConditions(),
    );
  }

  Widget _caseConditions() {
    if (pageType == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    switch (pageType) {
      case PageType.error:
        return ErrorWidget(Exception(_error));
      case PageType.needConnect:
        return const Center(
          child: Text('For application working need internet connection'),
        );
      case PageType.webView:
        return SafeArea(
          child: SizedBox.expand(
            child: Home(url: _url!),
          ),
        );
      case PageType.plug:
        return const ServicePage();
      default:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
  }
}
