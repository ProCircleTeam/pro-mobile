import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';

class CustomDropdownInput<T> extends StatelessWidget {
  final String? labelText;
  final String? helperText;
  final T? value;
  final Widget? icon;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;

  const CustomDropdownInput({
    this.labelText,
    this.helperText,
    required this.value,
    required this.items,
    required this.onChanged,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      items: items,
      icon: icon,
      onChanged: onChanged,
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
