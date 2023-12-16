import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../theme/colors.dart';
import '../../../utils/Routes/RoutesName.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool _animationFinished = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1750), () {
      setState(() {
        _animationFinished = true;
        _initiateNavigation();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              switchInCurve: Curves.easeOut,
              child: _animationFinished
                  ? _buildHuitScoreText()
                  : _buildLottieAnimation(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLottieAnimation() {
    return Center(
      child: Lottie.asset(
        'assets/splash.json',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fitWidth,
        repeat: false,
        animate: true,
      ),
    );
  }

  Widget _buildHuitScoreText() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'HuitScore',
          style: TextStyle(
            fontSize: 52,
            fontFamily: 'Inter_700',
            color: onSurfaceBlack12,
          ),
        ),
      ],
    );
  }

  Future<void> _initiateNavigation() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, RoutesName.introduce);
  }
}

// child: Column(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//   ],
// children: <Widget>[
//   SizedBox(height: 20),
//   Text(
//     'HuitScore',
//     style: TextStyle(
//       fontSize: 48,
//       fontFamily: 'Inter_700',
//       color: onSurfaceBlack12,
//     ),
//   ),
//   SizedBox(
//     height: 127.0,
//   ),
// ],
