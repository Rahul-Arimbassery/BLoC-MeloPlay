import 'package:flutter/material.dart';
import 'package:musicuitest/pages/navigatorpage.dart';
import 'package:musicuitest/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 250, 250, 251),
      ),
    );
  }
}