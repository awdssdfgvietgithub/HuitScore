import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class HeaderWithSeeAll extends StatelessWidget {
  final String title;
  final bool isShowSeeAllButton;
  final VoidCallback onSeeAllClicked;

  const HeaderWithSeeAll(
      {super.key,
      required this.isShowSeeAllButton,
      required this.title,
      required this.onSeeAllClicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              height: 1.4,
              fontFamily: 'Inter_700',
              color: onBackground,
              letterSpacing: 0.36,
            ),
          ),
          const Spacer(),
          Visibility(
            visible: isShowSeeAllButton,
            child: InkWell(
                onTap: () {
                  onSeeAllClicked();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter_600',
                        color: primary,
                        letterSpacing: 0.36,
                      ),
                    ), // Button text
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      size: 17,
                      color: primary,
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
