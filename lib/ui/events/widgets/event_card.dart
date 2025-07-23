import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/ui/widgets/action_button.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';

class EventCard extends StatelessWidget {
  final String title;

  const EventCard({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * .2,
      width: size.width,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .035,
        vertical: size.height * .015,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.height * .005),
        border: Border.all(color: AppColors.tinGrey.withValues(alpha: .2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                children: [
                  CustomText(
                    "10",
                    color: AppColors.red,
                    size: size.height * .023,
                    weight: FontWeight.bold,
                  ),
                  CustomText(
                    "August",
                    color: AppColors.red,
                    size: size.height * .016,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              SizedBox(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(title, weight: FontWeight.bold, size: size.height * .023, color: AppColors.appBlack.withValues(alpha: .8),),
                    CustomText("2:00pm", size: size.height * .018, color: AppColors.appBlack.withValues(alpha: .8),),
                    CustomText("Google meet", size: size.height * .018, color: AppColors.appBlack.withValues(alpha: .8),),
                  ],
                ),
              ), 
              Expanded(child: ActionButton(title: "Notify Me", onTap: (){}))
            ],
          ),
        ],
      ),
    );
  }
}
