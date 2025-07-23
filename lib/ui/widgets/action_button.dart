import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/ui/widgets/app_text_style.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final bool isLoading;
  final Color? bgColor;
  final Widget? title2;
  final double? verticalPadding;
  final Color? textColor;
  final Color? borderColor;

  const ActionButton({
    required this.title,
    required this.onTap,
    this.verticalPadding,
    this.isLoading = false,
    this.bgColor,
    this.title2,
    super.key,
    this.textColor,
    this.borderColor,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.primary,
          borderRadius: BorderRadius.circular(7),
          border: borderColor != null ?  Border.all(color: borderColor!) : null
        ),
        child: Center(
          child:
              isLoading
                  ? SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(color: textColor ?? Colors.white),
                  )
                  : title2 ??
                      Text(
                        title,
                        style: AppTextStyle.medium(color: textColor ?? Colors.white),
                      ),
        ),
      ),
    );
  }
}
