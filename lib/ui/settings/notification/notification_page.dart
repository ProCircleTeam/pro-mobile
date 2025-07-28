import 'package:flutter/material.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText("Notification", weight: FontWeight.bold),
      ),
      body: Center(child: CustomText("No current notification yet", size: 24,),),
    );
  }
}