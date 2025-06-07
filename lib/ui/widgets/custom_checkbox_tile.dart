import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';

class CustomCheckboxTile extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?> onChanged;
  final String label;

  const CustomCheckboxTile({
    required this.isChecked,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: [
        GestureDetector(
          onTap: () => onChanged(!isChecked),
          child: Container(
            width: size.width * .06,
            height: size.width * .06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.width * .018),
              border: Border.all(color: AppColors.primary, width: 1),
            ),
            child:
                isChecked
                    ? Icon(Icons.check, size: size.width * 0.055, color: AppColors.appBlack)
                    : null,
          ),
        ),
        SizedBox(width: 12),
        CustomText(label),
      ],
    );
  }
}
