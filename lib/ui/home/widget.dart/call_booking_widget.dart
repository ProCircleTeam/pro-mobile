import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';

class CallBookingWidget extends StatelessWidget {
  final String imageUrl;
  final Function onTap;
  final String partnerUserName;
  const CallBookingWidget({
    required this.imageUrl,
    required this.onTap,
    required this.partnerUserName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .02,
        vertical: size.height * .02,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            "Schedule  a call",
            size: size.height * .028,
            weight: FontWeight.bold,
          ),
          SizedBox(height: size.height * .015),
          Container(
            padding: EdgeInsets.symmetric(vertical: size.height * .012),
            decoration: BoxDecoration(
              color: AppColors.iceBlue.withValues(alpha: .5),
              borderRadius: BorderRadius.circular(size.height * .015),
            ),
            child: ListTile(
              leading: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder:
                      (context, url) => SizedBox(
                        width: size.width * .10,
                        height: size.width * .10,
                        child: CircularProgressIndicator(),
                      ),
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  width: size.width * .10,
                  height: size.width * .10,
                ),
              ),
              title: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          'You are about to schedule a call with your accountability partner ',
                    ),
                    TextSpan(
                      text: '@$partnerUserName',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * .015),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              InkWell(
                onTap: () {
                  onTap();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.height * .018,
                    vertical: size.height * .0093,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.goalBorderColor2,
                    borderRadius: BorderRadius.circular(size.height * .025),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    size: size.height * .027,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
