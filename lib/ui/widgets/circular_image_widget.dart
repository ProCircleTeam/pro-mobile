import 'dart:io';

import 'package:flutter/material.dart';

class CircularNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double size;

  const CircularNetworkImageWidget({
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
class CircularImageWidget extends StatelessWidget {
  final File image;
  final double size;

  const CircularImageWidget({
    required this.image,
    required this.size, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.file(
        image,
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}
