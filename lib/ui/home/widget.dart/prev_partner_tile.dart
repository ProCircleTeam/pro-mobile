import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';

class PrevPartnerTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  const PrevPartnerTile({required this.name, required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.height * .0075,
        horizontal: size.height * .003,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.appBlack.withValues(alpha: .15)),
        borderRadius: BorderRadius.circular(size.width * .02),
      ),
      child: ListTile(
        leading: ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder:
                (context, url) => SizedBox(
                  width: size.width * .11,
                  height: size.width * .11,
                  child: CircularProgressIndicator(),
                ),
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Icon(Icons.error),
            width: size.width * .13,
            height: size.width * .13,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              name,
              size: 16,
              weight: FontWeight.bold,
              color: AppColors.appBlack,
            ),
            CustomText(
              "Project Manager",
              size: 12,
              weight: FontWeight.bold,
              color: AppColors.lightBlack,
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              "July 7th -July 14th",
              size: 12,
              weight: FontWeight.bold,
              color: AppColors.lightBlack,
            ),
          ],
        ),
      ),
    );
  }
}
