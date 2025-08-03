import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/ui/utils/enum/goals_enum.dart';
import 'package:pro_mobile/ui/widgets/action_button.dart';
import 'package:pro_mobile/ui/widgets/custom_checkbox_tile.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/spacing_widget.dart';

class GoalModalContent extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(title, weight: FontWeight.bold, size: size.height * .02),
            IconButton(
              icon: Icon(Icons.edit_outlined),
              onPressed: () => onEditGoal(),
              color: AppColors.appBlack.withOpacity(0.5),
            ),
          ],
        ),
        SizedBox(height: size.height * .02),

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
              ...goals.map((el) {
                return Column(
                  children: [
                    CustomCheckboxTile(onChanged: (e) {}, label: goals[0]),
                    SizedBox(height: size.height * .017),
                  ],
                );
              }),
            ],
          ),
        ),

        SizedBox(height: size.height * .02),
        if (status == GoalStatusEnum.inProgress)
          ActionButton(title: "Mark as completed", onTap: () {}),
      ],
    );
  }
}
