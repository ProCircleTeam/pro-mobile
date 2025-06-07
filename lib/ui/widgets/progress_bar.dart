import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';

class ProgressBar extends StatelessWidget {
  final double progressBarLength;
  final double percentageCompletion;

  const ProgressBar({
    required this.progressBarLength,
    required this.percentageCompletion,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          height: size.height * .008,
          width: progressBarLength,
          decoration: BoxDecoration(
            color: AppColors.transparentGrey,
            borderRadius: BorderRadius.circular(size.height * .008),
          ),
        ),
        Container(
          height: size.height * .008,
          width: progressBarLength * percentageCompletion,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(size.height * .008),
          ),
        ),
      ],
    );
  }
}
