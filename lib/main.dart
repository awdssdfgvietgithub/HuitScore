import 'package:flutter/material.dart';
import 'package:huit_score/theme/colors.dart';
import 'package:huit_score/ui/screens/Onboarding/SplashScreen.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Splash Screen',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
