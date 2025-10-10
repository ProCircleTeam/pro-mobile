import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/domain/models/user_model.dart';
import 'package:pro_mobile/ui/utils/helper.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/progress_bar.dart';
import 'package:pro_mobile/ui/widgets/spacing_widget.dart';

class AccountabilityPartnerCard extends StatelessWidget {
  final UserModel? partner;
  final int noOfGoalsSet;
  final int completedGoals;
  final Function onTap;
  const AccountabilityPartnerCard({
    required this.partner,
    required this.onTap,
    required this.noOfGoalsSet,
    required this.completedGoals,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final progressBarLength = size.width * 0.35;

    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
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
            partner != null
                ? Column(
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl:
                               partner!.profilePhoto!,
                            placeholder:
                                (context, url) => SizedBox(
                                  width: size.width * .07,
                                  height: size.width * .07,
                                  child: CircularProgressIndicator(),
                                ),
                            fit: BoxFit.cover,
                            errorWidget:
                                (context, url, error) => Icon(Icons.error),
                            width: size.width * .09,
                            height: size.width * .09,
                          ),
                        ),

                        SpacingWidget(degree: .03, isVertical: false),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText("@${partner!.username}", size: 15),
                            CustomText(
                              Helper().truncateWithEllipsis(
                                13,
                                partner!.jobTitle!,
                              ),
                              size: 14,
                              color: AppColors.appBlack,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
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
                        CustomText(
                          "$completedGoals out of $noOfGoalsSet goals",
                          space: 1.5,
                        ),
                      ],
                    ),
                  ],
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpacingWidget(degree: .035),
                    CustomText("Waiting to be paired"),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
