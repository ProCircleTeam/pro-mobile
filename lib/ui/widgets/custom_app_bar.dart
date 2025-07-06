import 'package:flutter/material.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';

PreferredSizeWidget customAppBer(String title) => AppBar(
  title: CustomText(title, weight: FontWeight.bold),
  centerTitle: true,
);
