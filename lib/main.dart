import 'package:flutter/material.dart';
import 'package:hacknu_mobile/core/local_storage.dart';
import 'package:hacknu_mobile/navigation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CustomLocalStorage.init();
  runApp(const App());
}
