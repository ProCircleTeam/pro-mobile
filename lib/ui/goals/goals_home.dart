import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/ui/widgets/action_button.dart';
import 'package:pro_mobile/ui/widgets/custom_app_bar.dart';
import 'package:pro_mobile/ui/widgets/custom_bottom_modal.dart';
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
              height: size.height - (size.height * .37),
              child: Column(
                children: [
                  WarningBar(),
                  SizedBox(height: size.height * 0.04),
                  Row(
                    children: [
                      CustomText("Goals", weight: FontWeight.bold, size: size.height * .022),
                      SizedBox(width: size.width * .02),
                      CustomText("(3 of 5)", size: size.height * .022),
                    ],
                  ),
                  SizedBox(height: size.height * .014),
                  Row(
                    children: [
                      InkWell(
                        child: CustomText(
                          "+ Add  Goal",
                          size: size.height * .019,
                          weight: FontWeight.bold,
                          color: AppColors.primary.withValues(alpha: .65),
                        ),
                        onTap: () {
                          CustomBottomModal.show(
                            context: context,
                            isDismissible: false,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * .02,
                                vertical: size.height * .02,
                              ),
                              child: SizedBox(
                                width: size.width,
                                height: size.height * .35,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          "Add Goal",
                                          weight: FontWeight.bold,
                                          size: size.height * .022,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(Icons.close, size: size.height * .026),
                                        ),
                                      ],
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        hintText: 'Enter goal',
                                      ),
                                    ),

                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: ActionButton(
                                                title: "Cancel",
                                                bgColor: AppColors.primary
                                                    .withValues(alpha: .5),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                            SizedBox(width: size.width * .15),
                                            Expanded(
                                              child: ActionButton(
                                                title: "Add",
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: size.height * .02),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                ActionButton(title: "Submit", onTap: () {}),
                SizedBox(height: size.height * 0.015),
                InkWell(
                  child: CustomText(
                    "Save and Continue Later",
                    size: size.height * .017,
                    weight: FontWeight.bold,
                    color: AppColors.primary.withValues(alpha: .8),
                  ),
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
