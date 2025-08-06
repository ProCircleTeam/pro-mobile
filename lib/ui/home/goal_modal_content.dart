import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/ui/utils/enum/goals_enum.dart';
import 'package:pro_mobile/ui/widgets/action_button.dart';
import 'package:pro_mobile/ui/widgets/custom_checkbox_tile.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/progress_bar.dart';
import 'package:pro_mobile/ui/widgets/spacing_widget.dart';

class GoalModalContent extends StatefulWidget {
  final String title;
  final GoalStatusEnum status;
  final List<String> goals;
  final Function onEditGoal;

  const GoalModalContent({
    required this.title,
    required this.status,
    required this.goals,
    required this.onEditGoal,
    super.key,
  });

  @override
  State<GoalModalContent> createState() => _GoalModalContentState();
}

class _GoalModalContentState extends State<GoalModalContent> {
  Map<String, bool> checkingStore = {};

  @override
  void initState() {
    for (int i = 0; i < widget.goals.length; i++) {
      checkingStore["$i"] = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double progressBarLength = size.width * .85;
    int noOfCompletedGoals =
        checkingStore.values.where(((val) => val == true)).length;
    double percentageCompletion =
        noOfCompletedGoals / checkingStore.values.length;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              widget.title,
              weight: FontWeight.bold,
              size: size.height * .02,
            ),
            widget.status == GoalStatusEnum.inProgress
                ? SizedBox()
                : IconButton(
                  icon: Icon(Icons.edit_outlined),
                  onPressed: () => widget.onEditGoal(),
                  color: AppColors.appBlack.withValues(alpha: 0.5),
                ),
          ],
        ),
        SizedBox(height: size.height * .02),
        SpacingWidget(degree: 0.005),

        if (widget.status == GoalStatusEnum.inProgress)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText("Progress"),
                  CustomText(
                    "${(percentageCompletion * 100).toInt()}%",
                    color: AppColors.primary,
                    weight: FontWeight.bold,
                    size: 15,
                  ),
                ],
              ),
              SpacingWidget(degree: 0.005),
              ProgressBar(
                progressBarLength: progressBarLength,
                percentageCompletion: percentageCompletion,
              ),
              SpacingWidget(degree: 0.012),
            ],
          ),

        Container(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * .04,
            vertical: size.height * .015,
          ),
          decoration: BoxDecoration(
            color: AppColors.inputBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ...widget.goals.map((el) {
                return Column(
                  children: [
                    CustomCheckboxTile(
                      onChanged: (e) {
                        if (widget.status == GoalStatusEnum.inProgress) {
                          setState(() {
                            checkingStore["${widget.goals.indexOf(el)}"] = e;
                          });
                        }
                      },
                      label: el,
                    ),
                    SizedBox(height: size.height * .017),
                  ],
                );
              }),
            ],
          ),
        ),

        SizedBox(height: size.height * .02),
        if (widget.status == GoalStatusEnum.inProgress)
          ActionButton(
            title: "Mark as completed",
            onTap: () {
              Navigator.pop(context);
            },
          ),
      ],
    );
  }
}
