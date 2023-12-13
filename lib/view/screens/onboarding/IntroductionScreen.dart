import 'package:flutter/material.dart';
import 'package:huit_score/res/extensions/NavigatorExtension.dart';
import 'package:huit_score/theme/colors.dart';

import '../../../res/components/IntroductionPage.dart';
import '../../../utils/Utils.dart';
import '../AppScaffold.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: IntroductionContent(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class IntroductionContent extends StatefulWidget {
  const IntroductionContent({super.key});

  @override
  State<StatefulWidget> createState() => _IntroductionContent();
}

class _IntroductionContent extends State<IntroductionContent> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: background,
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/messi_introduction.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 411,
                padding: const EdgeInsets.symmetric(vertical: 48),
                decoration: const BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(60),
                    topLeft: Radius.circular(60),
                  ),
                ),
                child: SizedBox(
                  height: 200, // Set height as needed
                  child: PageView(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      IntroductionPage(
                        title:
                            'Update football match schedule everyday with HuitScore now!',
                        onClicked: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        buttonText: 'Next',
                      ),
                      IntroductionPage(
                        title: 'Update the fastest football news',
                        onClicked: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        buttonText: 'Next',
                      ),
                      IntroductionPage(
                        title: 'Wait for what? Let’s get start it!',
                        onClicked: () {
                          // // Navigator.pushNamed(context, RoutesName.scaffold);
                          context
                              .pushReplacementWithSlideTransitionClearBackstack(
                                  const AppScaffold());
                        },
                        buttonText: 'Lets start',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
