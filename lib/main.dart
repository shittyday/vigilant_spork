import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vigilant_spork/page/home.dart';

void main() async {
  runApp(const MainApp());
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(minutes: 5),
  ));

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  final uu = await storage.read(key: 'url');

  /// Если у нас нет url или она пуста, запрашиваем у удаленного фаербейс конфига
  /// После получения ссылки, создаем условие для проверки, если
  /// ссылка пустая, бренд смартфона гугл или эмулятор, тогда
  /// открывается заглушка.
  ///
  if (uu == null) {
    final url = remoteConfig.getString('url');
    storage.write(key: 'url', value: url);
  } else if (uu.isEmpty) {
    final url = remoteConfig.getString('url');
    storage.write(key: 'url', value: url);
  } else {}
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
          body: SafeArea(
        child: Home(),
      )),
    );
  }
}
