import 'package:flutter/material.dart';
import 'package:huit_score/view/screens/explore/matches/MatchesAllScreen.dart';
import '../../../utils/Routes/RoutesName.dart';
import 'package:huit_score/view/screens/AppScaffold.dart';
import 'package:huit_score/view/screens/Explore/ExploreScreen.dart';
import 'package:huit_score/view/screens/Home/HomeScreen.dart';
import 'package:huit_score/view/screens/News/NewsScreen.dart';
import 'package:huit_score/view/screens/Onboarding/IntroductionScreen.dart';
import 'package:huit_score/view/screens/Onboarding/SplashScreen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final argue = settings.arguments;
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      case RoutesName.introduce:
        return MaterialPageRoute(
            builder: (BuildContext context) => const IntroductionScreen());

      case RoutesName.scaffold:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AppScaffold());

      // case RoutesName.home:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const HomeScreen(model: null,));

      case RoutesName.explore:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ExploreScreen());

      case RoutesName.news:
        return MaterialPageRoute(
            builder: (BuildContext context) => const NewsScreen());

      // case RoutesName.matchesAllScreen:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const MatchesAllScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No Route Defined'),
            ),
          );
        });
    }
  }
}
