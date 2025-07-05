import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/ui/widgets/action_button.dart';
import 'package:pro_mobile/ui/widgets/custom_app_bar.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/padded_container.dart';
import 'package:pro_mobile/ui/widgets/warning_bar.dart';

class GoalsHomePage extends StatefulWidget {
  const GoalsHomePage({super.key});

  @override
  State<GoalsHomePage> createState() => _GoalsHomePageState();
}

class _GoalsHomePageState extends State<GoalsHomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: customAppBer("Upload  Goals"),
      body: PaddedContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: size.height - (size.height * .27),
              child: Column(
                children: [
                  WarningBar(),
                  SizedBox(height: size.height * 0.04),
                  Row(
                    children: [
                      CustomText("Goals", weight: FontWeight.bold, size: 24),
                      SizedBox(width: size.width * .02),
                      CustomText("(3 of 5)", size: 24),
                    ],
                  ),
                  SizedBox(height: size.height * .014,),
                  Row(
                    children: [
                      InkWell(child: CustomText("+ Add  Goal", size: 18, weight: FontWeight.bold, color: AppColors.primary.withValues(alpha: .65),), ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              children: [
                ActionButton(
                  title: "Submit",
                  onTap: () {
                    print("I am a chosen one");
                  },
                ),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
