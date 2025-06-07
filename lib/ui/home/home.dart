import 'package:flutter/material.dart';
import 'package:pro_mobile/app/routes/app_router.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/ui/home/widget.dart/goal_listing.dart';
import 'package:pro_mobile/ui/widgets/action_button.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/padded_container.dart';
import 'package:pro_mobile/ui/widgets/spacing_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: PaddedContainer(
        child: SizedBox(
          height: size.height,
          child: Column(
            children: [
              SpacingWidget(degree: .05),
              ListTile(
                leading: Container(
                  height: size.width * .11,
                  width: size.width * .11,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(size.width * .055),
                    image: DecorationImage(
                      image: AssetImage(PNGImageUrl.sampleProfilePix2),
                    ),
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "Hello, Xrole",
                      size: 16,
                      weight: FontWeight.bold,
                      color: AppColors.appBlack,
                    ),
                    CustomText(
                      "@winloop",
                      size: 12,
                      weight: FontWeight.bold,
                      color: AppColors.lightBlack,
                    ),
                  ],
                ),
                trailing: Stack(
                  children: [
                    Positioned(
                      left: 16,
                      bottom: 15,
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () {},
                      child: Icon(Icons.notifications_none, size: 25),
                    ),
                  ],
                ),
              ),
              SpacingWidget(degree: .02),
              SizedBox(
                width: size.width,
                child: Row(
                    children: [
                      Expanded(child: ActionButton(
                        verticalPadding: size.height * .013,
                        title: "", title2: Icon(Icons.add, color: Colors.white,), onTap: () {})),
                      SpacingWidget(degree: .05, isVertical: false,),
                      Expanded(child: ActionButton(
                        verticalPadding: size.height * .013,
                        title: "", bgColor: AppColors.secondary, title2: Icon(Icons.task_alt_outlined, color: Colors.white), onTap: () {})),
                    ],
                  ),
              ),
              SpacingWidget(degree: .04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText("This Week's Goal", weight: FontWeight.bold, size: 16,),
                  SizedBox(),
                ],
              ),
              SpacingWidget(degree: .01),
              GoalListing(goals: ["Build a strong portfolio", "Post twice on LinkedIn this week"],)
            ],
          ),
        ),
      ),
    );
  }
}