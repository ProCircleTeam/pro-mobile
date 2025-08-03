import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: CustomText("Notification", weight: FontWeight.bold),
      ),
      body:  Column(
        children: [
          SizedBox(height: size.height * .2),
          SizedBox(
            height: size.height * .15,
            child: SvgPicture.asset(SVGImageUrl.emptyNotification)),
          Center(child: CustomText("No notifications yet!", size: size.height * .018)),
        ],
      ),
    );
  }
}
