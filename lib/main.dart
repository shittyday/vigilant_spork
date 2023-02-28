import 'package:flutter/material.dart';
import 'package:vigilant_spork/page/app.dart';
import 'package:vigilant_spork/utils/boostrap.dart';

/// Если у нас нет url или она пуста, запрашиваем у удаленного фаербейс конфига
/// После получения ссылки, создаем условие для проверки, если
/// ссылка пустая, бренд смартфона гугл или эмулятор, тогда
/// открывается заглушка.
void main() async {
  await boostrap();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
      body: App(),
    ));
  }
}
