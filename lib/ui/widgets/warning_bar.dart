import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';

class WarningBar extends StatelessWidget {
  const WarningBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.height * .015, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.lightPrimary, 
        border: Border.all(color: AppColors.primary.withValues(alpha: .3)),
        borderRadius: BorderRadius.circular(3)
      ),
      child: Row(
        children: [
          SvgPicture.asset(SVGImageUrl.warningIcon),
          SizedBox(width: size.width * .05),
          CustomText("Note that you will . be paired only with the first goal", weight: FontWeight.bold,),
        ],
      ),
    );
  }
}