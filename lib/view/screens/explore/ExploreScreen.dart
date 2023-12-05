import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../res/components/MyDropdownMenu.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 24),
      child: Column(
        children: [
          MyDropdownMenu(),
          SizedBox(height: 28),
          // SingleChildScrollView(
          //   scrollDirection: Axis.vertical,
          //   child: DataTable(
          //     columns: [
          //
          //     ], rows: [],
          //   ),
          // )
        ],
      ),
    );
  }
}
