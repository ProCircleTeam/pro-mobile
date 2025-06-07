import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/progress_bar.dart';
import 'package:pro_mobile/ui/widgets/spacing_widget.dart';

class AccountabilityPartnerCard extends StatelessWidget {
  final int noOfGoalsSet;
  final int completedGoals;
  const AccountabilityPartnerCard({
    required this.noOfGoalsSet,
    required this.completedGoals,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final progressBarLength = size.width * 0.35;

    return Container(
      height: size.height * .15,
      padding: EdgeInsets.all(size.width * .03),
      decoration: BoxDecoration(
        color: AppColors.inputBg,
        borderRadius: BorderRadius.circular(size.width * .02),
      ),
      child: Column(
        children: [
          CustomText("Accountability Partner", weight: FontWeight.bold),
          SpacingWidget(degree: .01),
          Row(
            children: [
              Container(
                height: size.width * .09,
                width: size.width * .09,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(size.width * .045),
                  image: DecorationImage(
                    image: AssetImage(PNGImageUrl.sampleProfilePix),
                  ),
                ),
              ),

              SpacingWidget(degree: .03, isVertical: false),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText("@spark", size: 15),
                  CustomText(
                    "Medical Doctor ",
                    size: 14,
                    color: AppColors.appBlack,
                  ),
                ],
              ),
            ],
          ),
          SpacingWidget(degree: .02),
          ProgressBar(
            progressBarLength: progressBarLength,
            percentageCompletion: completedGoals / noOfGoalsSet,
          ),
          SpacingWidget(degree: .01),
          Row(
            children: [
              CustomText("$completedGoals out of $noOfGoalsSet goals", space: 1.5,),
            ],
          )
        ],
      ),
    );
  }
}
