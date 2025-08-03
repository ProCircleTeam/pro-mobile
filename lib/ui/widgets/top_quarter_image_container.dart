import 'package:flutter/material.dart';

class TopImageSection extends StatelessWidget {
  final String imageUrl;
  final double height;

  const TopImageSection({
    required this.imageUrl,
    required this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(22),
          bottomRight: Radius.circular(22),
        ),
        child: SizedBox(
          height: height,
          width: double.infinity,
          child: Image.network(imageUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
