import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class ExplainColorStandingDialog extends StatelessWidget {
  const ExplainColorStandingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.all(14),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildItem('UEFA Champions League Spot', Color(0xFF3766CF)),
          const SizedBox(height: 4), // Add a 4dp margin between items
          _buildItem('Champions League Qualification Spot', Color(0xFFEF7515)),
          const SizedBox(height: 4), // Add a 4dp margin between items
          _buildItem('UEFA Europa League Spot', Color(0xFFFF6900)),
          const SizedBox(height: 4), // Add a 4dp margin between items
          _buildItem(
              'UEFA Conference League Qualification Spot', Color(0xFF16B427)),
          const SizedBox(height: 4), // Add a 4dp margin between items
          _buildItem('Relegation Playoffs Spot', Color(0xFFEFB405)),
          const SizedBox(height: 4), // Add a 4dp margin between items
          _buildItem('Relegation', Color(0xFFE24E4E)),
        ],
      ),
    );
  }

  Widget _buildItem(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      // Apply vertical margin of 4dp
      child: Row(
        children: [
          Container(
            height: 20,
            width: 4,
            color: color,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Inter_400',
              color: onBackground,
            ),
          ),
        ],
      ),
    );
  }
}
