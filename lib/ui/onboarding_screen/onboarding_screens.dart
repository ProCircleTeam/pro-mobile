// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro_mobile/constants/constants.dart';
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
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(image, height: height * .25),
         SizedBox(height: height * .03 ),
        CustomText(
          title,
          size: 24, weight: FontWeight.bold),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
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
    );
  }
}
