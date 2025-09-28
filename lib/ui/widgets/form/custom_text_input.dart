import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/ui/widgets/spacing_widget.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final Widget? trailingIcon;
  final void Function(String)? onChanged;

  const CustomTextInput({
    super.key,
    this.controller,
    this.hintText = '',
    this.onChanged,
    this.trailingIcon,
    this.obscureText = false,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .05,
        vertical: size.height * .013,
      ),
      decoration: BoxDecoration(
        color: AppColors.inputBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.iconColor, size: size.width * .05),
          SpacingWidget(degree: .03, isVertical: false),
          Expanded(
            child: TextFormField(
              controller: controller,
              onChanged: onChanged,
              obscureText: obscureText,
              style: TextStyle(
                color: AppColors.appBlack.withAlpha(180),
                fontFamily: 'SourceSan3',
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                isCollapsed: true,
                hintStyle: TextStyle(color: AppColors.iconColor, fontSize: 14),
              ),
            ),
          ),
          if (trailingIcon != null) trailingIcon!,
        ],
      ),
    );
  }
}
