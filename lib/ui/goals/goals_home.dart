import 'package:flutter/material.dart';
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
      body: Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText("You are yet to \n complete a  goal", size: size.height * 0.018 ,),
      ],
    ),),);
  }
}