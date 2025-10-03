import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/domain/models/notification_item_model.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/spacing_widget.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationItemModel notification;
  const NotificationItemWidget({
    required this.notification,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .017,
        vertical: size.height * .015,
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Icon(
              Icons.notifications_none_outlined,
              color: AppColors.captionColor,
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  notification.title,
                  weight: FontWeight.bold,
                  size: size.height * .017,
                ),
                SpacingWidget(degree: .001),
                CustomText( notification.body, size: size.height * .017),
                SpacingWidget(degree: .005),
                CustomText(
                   notification.timestamp.toString(),
                  size: size.height * .015,
                  color: AppColors.captionColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
