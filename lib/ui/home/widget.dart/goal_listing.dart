import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/ui/widgets/custom_checkbox_tile.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/progress_bar.dart';
import 'package:pro_mobile/ui/widgets/spacing_widget.dart';

class GoalListing extends StatefulWidget {
  final List<String> goals;
  const GoalListing({required this.goals, super.key});

  @override
  State<GoalListing> createState() => _GoalListingState();
}

class _GoalListingState extends State<GoalListing> {
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

    return Container(
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
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            itemCount: widget.goals.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  CustomCheckboxTile(
                    onChanged: (e) {
                      setState(() {
                        checkingStore["$index"] = e;
                      });
                    },
                    label: widget.goals[index],
                  ),
                  SpacingWidget(degree: 0.012),
                ],
              );
            },
          ),

          SpacingWidget(degree: 0.005),
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
         ProgressBar(progressBarLength: progressBarLength, percentageCompletion: percentageCompletion),
          SpacingWidget(degree: 0.012),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: CustomText("See All", size: 14, weight: FontWeight.bold),
              ),
              SizedBox(),
            ],
          ),
          SpacingWidget(degree: 0.005),
        ],
      ),
    );
  }
}
