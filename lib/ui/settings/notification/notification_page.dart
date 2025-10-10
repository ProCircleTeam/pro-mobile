import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/domain/models/notification_item_model.dart';
import 'package:pro_mobile/providers/notification_provider.dart';
import 'package:pro_mobile/ui/settings/widgets/notification_item.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/padded_container.dart';
import 'package:pro_mobile/ui/widgets/spacing_widget.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    NotificationProvider notificationProvider =
        Provider.of<NotificationProvider>(context);
    final size = MediaQuery.of(context).size;
    List<NotificationItemModel> notifications =
        notificationProvider.notifications;

    return Scaffold(
      appBar: AppBar(
        title: CustomText("Notification", weight: FontWeight.bold),
      ),
      body:
          notifications.isNotEmpty
              ? ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      if (i == 0)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * .05,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SpacingWidget(degree: .02),
                                  CustomText(
                                    "Today",
                                    weight: FontWeight.w400,
                                    size: size.height * .018,
                                  ),
                                ],
                              ),
                              SpacingWidget(degree: .01),
                            ],
                          ),
                        ),
                      if (i == 2)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * .05,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CustomText(
                                    "Yesterday",
                                    weight: FontWeight.w400,
                                    size: size.height * .018,
                                  ),
                                ],
                              ),
                              SpacingWidget(degree: .01),
                            ],
                          ),
                        ),
                      if (i == 4)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * .05,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CustomText(
                                    "Older",
                                    weight: FontWeight.w400,
                                    size: size.height * .018,
                                  ),
                                ],
                              ),
                              SpacingWidget(degree: .01),
                            ],
                          ),
                        ),
                      NotificationItemWidget(notification: notifications[i]),
                      SpacingWidget(degree: .01),
                    ],
                  );
                },
              )
              : Column(
                children: [
                  SizedBox(height: size.height * .2),
                  SizedBox(
                    height: size.height * .15,
                    child: SvgPicture.asset(SVGImageUrl.emptyNotification),
                  ),
                  Center(
                    child: CustomText(
                      "No notifications yet!",
                      size: size.height * .018,
                    ),
                  ),
                ],
              ),
    );
  }
}
