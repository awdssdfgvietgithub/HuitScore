import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class NotFoundMatches extends StatelessWidget {
  final String title;
  final String subTitle;

  const NotFoundMatches(
      {super.key, required this.title, required this.subTitle});

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
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Inter_700',
              color: Color(0xFF212121),
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            subTitle,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Inter_400',
              color: Color(0xFF212121),
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
