import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class ImageWithDes extends StatelessWidget {
  final String imageUrl;
  final String des;

  const ImageWithDes({super.key, required this.imageUrl, required this.des});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) =>
              const Icon(Icons.error_outline_rounded),
          fit: BoxFit.fill,
          filterQuality: FilterQuality.high,
        ),
        Text(
          des,
          style: const TextStyle(
            fontSize: 12,
            color: onSurfaceBlack8,
            fontFamily: 'Inter_400',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
