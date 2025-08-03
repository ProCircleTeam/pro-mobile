import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/spacing_widget.dart';

class RemindersCard extends StatelessWidget {
  final Function onTap;
  const RemindersCard({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
            Row(children: [CustomText("Reminders", weight: FontWeight.bold)]),
            SpacingWidget(degree: .01),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
             
            ],),
          ],
        ),
      ),
    );
  }
}
