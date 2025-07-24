import 'package:flutter/material.dart';
import 'package:pro_mobile/app/routes/app_router.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/ui/widgets/circular_image_widget.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/padded_container.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: PaddedContainer(
        child: Column(
          children: [
            SizedBox(height: size.height * .05),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ],
            ),
            Center(
              child: Column(
                children: [
                  CircularNetworkImageWidget(
                    imageUrl: StringConstants.sampleProfileImage,
                    size: size.width * .4,
                  ),
                  SizedBox(height: size.height * .01),
                  CustomText(
                    "Xrole Diamond",
                    size: size.height * .023,
                    weight: FontWeight.bold,
                  ),
                  CustomText(
                    "Software Engineer",
                    size: size.height * .020,
                    color: AppColors.appBlack.withValues(alpha: 1),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * .02),
            Row(
              children: [
                Column(children: [TitleText(title: "About Me")]),
              ],
            ),
            CustomText(
              "I build seamless modern technologies for web and mobile platforms. I’m based in Lagos and I love coffee.",
              size: size.height * .016,
              height: 1.5,
            ),
            SizedBox(height: size.height * .03),
            Row(
              children: [
                Column(children: [TitleText(title: "Basic Info")]),
              ],
            ),
            Row(
              children: [
                CustomText(
                  "No available basic info, Kindly update your profile",
                  size: size.height * .016,
                  height: 1.5,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRouter.profileUpdate);
        },
        backgroundColor: AppColors.secondary,
        child: Icon(Icons.edit, color: AppColors.primary),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  final String title;
  const TitleText({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return CustomText(
      title,
      size: size.height * .018,
      weight: FontWeight.bold,
      textAlign: TextAlign.right,
    );
  }
}
