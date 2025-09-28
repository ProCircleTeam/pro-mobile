import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/spacing_widget.dart';

class GoalEmptyState extends StatelessWidget {
  const GoalEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.maxFinite,
       padding: EdgeInsets.symmetric(vertical:  size.width * .07),
      decoration: BoxDecoration(
        color: AppColors.inputBg,
        borderRadius: BorderRadius.circular(size.width * .02),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(SVGImageUrl.emptyNotification, height: size.height * .03),
          SpacingWidget(degree: .01),
          CustomText("Don’t be Lazy, Set your Goals Now!", size: size.height * .02, color: AppColors.appBlack.withValues(alpha: 1)),
          SpacingWidget(degree: .004),
          CustomText("Set a goal and track your", size: size.height * .016, color: AppColors.appBlack.withValues(alpha: .8),),
          CustomText("progress this week", size: size.height * .015, color: AppColors.appBlack.withValues(alpha: .8)),
        ],
      ),
    );
  }
}
