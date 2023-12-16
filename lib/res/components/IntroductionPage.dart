import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../theme/colors.dart';

class IntroductionPage extends StatelessWidget {
  final String title;
  final VoidCallback onClicked;
  final String buttonText;
  final String lottieAsset;
  final double size;

  const IntroductionPage(
      {super.key,
      required this.title,
      required this.onClicked,
      required this.buttonText,
      required this.lottieAsset, required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 32.0,
                height: 1.2,
                color: onSurfaceBlack12,
                fontFamily: 'Inter_700',
                decoration: TextDecoration.none),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Lottie.asset(lottieAsset, height: size, width: size, fit: BoxFit.fitWidth),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  onClicked();
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(primary),
                  foregroundColor: MaterialStateProperty.all<Color>(surface),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 18.0), // Adjust the padding as needed
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(buttonText,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Inter_700',
                      )),
                )),
          )
        ],
      ),
    );
  }
}
