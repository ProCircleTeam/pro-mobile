import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';

class GoalsHome extends StatefulWidget {
  const GoalsHome({super.key});

  @override
  State<GoalsHome> createState() => _GoalsHomeState();
}

class _GoalsHomeState extends State<GoalsHome> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: CustomText("Goals", weight: FontWeight.bold),
        leading: SizedBox(),
      ),
      body: Column(
        children: [
          SizedBox(height: size.height * .2),
          SizedBox(
            height: size.height * .15,
            child: SvgPicture.asset(SVGImageUrl.emptyHome)),
          Center(child: CustomText("No Goal set yet!", size: size.height * .018)),
        ],
      ),
    );
  }
}
