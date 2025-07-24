import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';

class MultilineTextInput extends StatelessWidget {
  final String? labelText;
  final String? helperText;
  final TextEditingController? controller;
  final int maxLines;
   final int? maxLength;

  const MultilineTextInput({
    this.labelText,
    this.helperText,
    this.controller,
    this.maxLines = 5,
    this.maxLength,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines, 
      keyboardType: TextInputType.multiline,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: labelText,
        helperText: helperText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: AppColors.softGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: AppColors.softGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: AppColors.softGrey, width: 2),
        ),
      ),
    );
  }
}
