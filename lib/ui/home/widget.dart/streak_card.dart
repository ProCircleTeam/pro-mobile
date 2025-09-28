import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/spacing_widget.dart';

class StreakCard extends StatelessWidget {
  final bool hasStreak;
  const StreakCard({required this.hasStreak, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * .15,
      padding: EdgeInsets.all(size.width * .03),
      decoration: BoxDecoration(
        color: AppColors.inputBg,
        borderRadius: BorderRadius.circular(size.width * .02),
      ),
      child: Column(
        children: [
          Row(children: [CustomText("Streak", weight: FontWeight.bold)]),
          SpacingWidget(degree: .01),
          hasStreak
              ? Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(SVGImageUrl.trophy),
                      SpacingWidget(degree: 0.02, isVertical: false),
                      CustomText("6 Goals", weight: FontWeight.bold, size: 22),
                    ],
                  ),
                  SpacingWidget(degree: .015),
                  CustomText("Completed", weight: FontWeight.w100),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText("You are on fire !", weight: FontWeight.w100),
                      SpacingWidget(degree: 0.02, isVertical: false),
                      SvgPicture.asset(SVGImageUrl.fire),
                    ],
                  ),
                ],
              )
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpacingWidget(degree: .035),
                  CustomText("No streak yet"),
                ],
              ),
        ],
      ),
    );
  }
}
