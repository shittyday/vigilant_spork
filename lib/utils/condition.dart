import 'package:device_info_plus/device_info_plus.dart';
import 'package:vigilant_spork/utils/page_type.dart';

import 'database.dart';

/// Проверяю условие, что не эмулятор и не гугл
Future<bool> get condition async {
  final deviceInfo = DeviceInfoPlugin();
  final emulator = await deviceInfo.androidInfo;
  final phoneModel = emulator.model;
  final buildProduct = emulator.product;
  final buildHardware = emulator.hardware;
  bool result = emulator.fingerprint.startsWith("generic") ||
      phoneModel.contains("google_sdk") ||
      phoneModel.contains("droid4x") ||
      phoneModel.contains("Emulator") ||
      phoneModel.contains("Android SDK built for x86") ||
      emulator.manufacturer.contains("Genymotion") ||
      buildHardware == "goldfish" ||
      buildHardware == "vbox86" ||
      buildProduct == "sdk" ||
      buildProduct == "google_sdk" ||
      buildProduct == "sdk_x86" ||
      buildProduct == "vbox86p" ||
      emulator.brand.contains('google') ||
      emulator.board.toLowerCase().contains("nox") ||
      emulator.bootloader.toLowerCase().contains("nox") ||
      buildHardware.toLowerCase().contains("nox") ||
      !emulator.isPhysicalDevice ||
      buildProduct.toLowerCase().contains("nox");
  if (!result) {
    result = result ||
        (emulator.brand.startsWith("generic") &&
            emulator.device.startsWith("generic"));
    if (!result) {
      result = result || ("google_sdk" == buildProduct);
    }
  }
  return result;
}

PageType connectionResultType(bool connection) {
  if (!connection) {
    return PageType.needConnect;
  }
  return PageType.webView;
}

Future<PageType> remoteConfigResultType({
  required String url,
  required bool emulatorOrNoSim,
  required Database database,
}) async {
  if (url.isEmpty || emulatorOrNoSim) {
    return PageType.plug;
  }
  await database.urlHelper(url);
  return PageType.webView;
}
