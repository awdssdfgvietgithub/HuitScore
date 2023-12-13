import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class NotFoundMatches extends StatelessWidget {
  const NotFoundMatches({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/not_found.svg',
            width: double.infinity,
            height: 150,
          ),
          const Text(
            "So Sad!",
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Inter_700',
              color: Color(0xFF212121),
            ),
          ),
          const Text(
            "There are currently no matches.",
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter_400',
              color: Color(0xFF212121),
            ),
          )
        ],
      ),
    );
  }
}
