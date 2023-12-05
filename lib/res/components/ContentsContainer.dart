import 'package:flutter/cupertino.dart';

class ContentsContainer extends StatelessWidget {
  final Widget title;
  final Widget content;

  const ContentsContainer(
      {super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        title,
        const SizedBox(height: 12),
        content,
      ],
    );
  }
}
