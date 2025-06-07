import 'package:flutter/material.dart';

class SpacingWidget extends StatelessWidget {
  final bool isVertical;
  final num degree;
  const SpacingWidget({
    required this.degree,
    this.isVertical = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return isVertical ? SizedBox(
      height: size.height * degree,
    ) : SizedBox(
      width: size.width * degree,
    );
  }
}
