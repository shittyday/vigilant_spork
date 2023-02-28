import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String _url = 'url';

class Database {
  final _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  Future<String?> get url async => await _storage.read(key: _url);
  Future<void> urlHelper(String? value) async =>
      await _storage.write(key: _url, value: value);
}
