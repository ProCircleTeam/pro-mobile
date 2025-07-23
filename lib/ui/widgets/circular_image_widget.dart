import 'package:flutter/material.dart';

class CircularImageWidget extends StatelessWidget {
  final String imageUrl;
  final double size;

  const CircularImageWidget({
    required this.imageUrl,
    required this.size, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}
