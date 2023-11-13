import 'package:flutter/material.dart';
import 'package:huit_score/ui/screens/Onboarding/IntroductionScreen.dart';
import '../../../theme/colors.dart';
import '../Home/HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const IntroductionScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'HuitScore',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
                color: onSurfaceBlack12,
              ),
            ),
            SizedBox(
              height: 127.0,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
