import 'package:flutter/material.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';

class SettingsPage extends StatefulWidget {
  final String title;
  const SettingsPage({required this.title, super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CustomText(widget.title)));
  }
}
