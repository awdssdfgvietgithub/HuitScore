import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huit_score/theme/colors.dart';

class CategoryItem extends StatelessWidget {
  final String resImage;

  const CategoryItem({super.key, required this.resImage});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        height: 176,
        padding: const EdgeInsets.all(12),
        child: Image.asset(
          resImage, // Replace with your image URL
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
