import 'package:flutter/material.dart';
import 'package:huit_score/utils/Routes/Routes.dart';
import 'package:huit_score/utils/Routes/RoutesName.dart';

void main() {
  runApp(const MaterialApp(
    home: SafeArea(child: Scaffold(body: MyApp())),
    debugShowCheckedModeBanner: false,
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
      initialRoute: RoutesName.splash,
      onGenerateRoute: Routes.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
