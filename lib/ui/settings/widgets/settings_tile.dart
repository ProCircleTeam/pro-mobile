import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/faded_stroke.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  final bool showDivider;
  final Widget? trailingWidget;
  const SettingsTile({
    required this.title,
    required this.icon,
    required this.onTap,
    this.showDivider = true,
    this.trailingWidget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: AppColors.appBlack.withValues(alpha: .5)),
          title: CustomText(title, size: size.height * .018),
          trailing: trailingWidget ?? Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: AppColors.appBlack.withValues(alpha: .5),
          ),
          onTap: () => onTap(),
        ),
        if (showDivider)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * .03,
              vertical: size.height * .00,
            ),
            child: FadedStroke(),
          ),
      ],
    );
  }
}
