import 'package:flutter/material.dart';
import 'package:pro_mobile/app/routes/app_router.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(context, AppRouter.onboarding);
          },
          child: CustomText(
            "Welcome to ProCircle",
            size: 22,
            weight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
