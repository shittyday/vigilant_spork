import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Проверяю коннект
Future<bool> get checkInternet async =>
    await InternetConnectionChecker().hasConnection;
