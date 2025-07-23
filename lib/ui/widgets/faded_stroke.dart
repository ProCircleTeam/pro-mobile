import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';

class FadedStroke extends StatelessWidget {
  const FadedStroke({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(height: 5, color: AppColors.appBlack.withValues(alpha: .15),);
  }
}