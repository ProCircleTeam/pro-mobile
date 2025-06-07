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
  const ActionButton({
    required this.title,
    required this.onTap,
    this.verticalPadding,
    this.isLoading = false,
    this.bgColor,
    this.title2,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
        ),
        child: Center(
          child:
              isLoading
                  ? const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                  : title2 ??
                      Text(
                        title,
                        style: AppTextStyle.medium(color: Colors.white),
                      ),
        ),
      ),
    );
  }
}
