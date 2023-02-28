import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:vigilant_spork/firebase_options.dart';

Future<void> boostrap() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      name: 'vigilant_spork',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    rethrow;
  }
}
