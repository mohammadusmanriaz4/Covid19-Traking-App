import 'package:covid19_tracking_app/View/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
  home: SplashScreen(),
  );
  }
}


