import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class HeaderWithSeeAll extends StatelessWidget {
  final String title;
  final bool isShowSeeAllButton;
  final VoidCallback onSeeAllClicked;
  final bool isShowAllMatches;

  const HeaderWithSeeAll(
      {super.key,
      required this.isShowSeeAllButton,
      required this.title,
      required this.onSeeAllClicked,
      required this.isShowAllMatches});

  @override
  Widget build(BuildContext context) {
    IconData seeAllIcon;
    String seeAllTile;
    if (isShowAllMatches) {
      seeAllIcon = Icons.keyboard_arrow_down_rounded;
      seeAllTile = 'Show less';
    } else {
      seeAllIcon = Icons.keyboard_arrow_right_rounded;
      seeAllTile = 'Show more';
    }
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      seeAllTile,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter_600',
                        color: primary,
                        letterSpacing: 0.36,
                      ),
                    ), // Button text
                    Icon(
                      seeAllIcon,
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
