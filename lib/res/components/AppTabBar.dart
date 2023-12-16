import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class AppTabBar extends StatelessWidget {
  final TabController tabController;
  final List<String> tabs;

  const AppTabBar({super.key, required this.tabController, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: surface,
      child: TabBar(
        controller: tabController,
        tabs: List.generate(tabs.length, (index) {
          return Tab(text: tabs[index]);
        }),
        labelColor: primary,
        unselectedLabelColor: onSecondary,
        labelStyle: const TextStyle(
          fontFamily: 'Inter_700',
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Inter_700',
          fontSize: 14,
        ),
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(width: 3, color: primary),
        ),
      ),
    );
  }
}
