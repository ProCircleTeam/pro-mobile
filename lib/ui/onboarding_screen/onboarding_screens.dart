// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro_mobile/app/routes/app_router.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/ui/widgets/action_button.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * .05,
          vertical: height * .065,
        ),
        child: PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              pageIndex = index;
            });
          },
          children: [
            buildPage(
              image: SVGImageUrl.onboardingImage1,
              title: 'Welcome to ProCircle',
              description:
                  'A community where goals turn into achievement through collaboration, mentorship and unwavering support.',
            ),
            buildPage(
              image: SVGImageUrl.onboardingImage2,
              title: 'Grow Your Network And Opportunities',
              description:
                  'Connect with industry professionals and unlock doors for collaborations, jobs and partnership.',
            ),
            buildPage(
              image: SVGImageUrl.onboardingImage3,
              title: 'Build Friendships Through Fun And Retreat',
              description:
                  'Recharge and bond with community who values fun as much as growth.',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPage({
    required String image,
    required String title,
    required String description,
  }) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(height: height * .015),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                pageIndex == 0
                    ? const SizedBox()
                    : IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        _controller.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                    ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, AppRouter.auth);
                  },
                  child: CustomText("Skip", weight: FontWeight.bold, size: 16),
                ),
              ],
            ),
            SizedBox(height: height * .055),
            SvgPicture.asset(image, height: height * .3),
            SizedBox(height: height * .055),
            CustomText(
              title,
              size: 22,
              weight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height * .005),
            CustomText(
              description,
              textAlign: TextAlign.center,
              size: 16,
              height: 1.2,
            ),
            SizedBox(height: height * .03),
            Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: WormEffect(
                  dotHeight: 12,
                  dotWidth: 12,
                  activeDotColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),

        ActionButton(
          title: pageIndex < 2 ? "NEXT" : "GET STARTED",
          onTap: () async {
            if (pageIndex == 2) {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('onboarding_done', true);
              Navigator.pushReplacementNamed(context, AppRouter.auth);
            } else {
              _controller.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            }
          },
        ),
      ],
    );
  }
}
