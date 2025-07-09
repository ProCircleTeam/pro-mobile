import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';

class CustomCheckboxTile extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final String label;

  const CustomCheckboxTile({
    required this.onChanged,
    required this.label,
    super.key,
  });

  @override
  State<CustomCheckboxTile> createState() => _CustomCheckboxTileState();
}

class _CustomCheckboxTileState extends State<CustomCheckboxTile> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isChecked = !isChecked;
            });
            widget.onChanged(isChecked);
          },
          child: Container(
            width: size.width * .06,
            height: size.width * .06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.width * .018),
              border: Border.all(color: AppColors.primary, width: 1),
            ),
            child:
                isChecked
                    ? Icon(
                      Icons.check,
                      size: size.width * 0.055,
                      color: AppColors.appBlack,
                    )
                    : null,
          ),
        ),
        SizedBox(width: 12),
        Expanded(child: CustomText(widget.label)),
      ],
    );
  }
}
