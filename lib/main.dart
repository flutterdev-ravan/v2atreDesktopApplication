import 'dart:io';

import 'package:atre_windows/Constants/myColors.dart';
import 'package:atre_windows/Screens/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Atre');
    setWindowMinSize(const Size(1536, 864));
    setWindowMaxSize(Size.infinite);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Atre Health Tech',
        theme: ThemeData(
            textSelectionTheme:
                TextSelectionThemeData(cursorColor: myColors.greenColor)),
        home: Login());
  }
}
