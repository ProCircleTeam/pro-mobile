import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/domain/models/user_model.dart';
import 'package:pro_mobile/providers/user_provider.dart';
import 'package:pro_mobile/ui/settings/profile/profile.dart';
import 'package:pro_mobile/ui/widgets/circular_image_widget.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/padded_container.dart';
import 'package:pro_mobile/ui/widgets/top_quarter_image_container.dart';
import 'package:provider/provider.dart';

class PartnerProfilePage extends StatefulWidget {
  const PartnerProfilePage({super.key});

  @override
  State<PartnerProfilePage> createState() => _PartnerProfilePageState();
}

class _PartnerProfilePageState extends State<PartnerProfilePage> {
  @override
  Widget build(BuildContext context) {
    String samplePartnerImage =
        "https://media.istockphoto.com/id/1386479313/photo/happy-millennial-afro-american-business-woman-posing-isolated-on-white.jpg?s=612x612&w=0&k=20&c=8ssXDNTp1XAPan8Bg6mJRwG7EXHshFO5o0v9SIj96nY=";
    UserProvider userProvider = Provider.of<UserProvider>(context);
    UserModel? partner = userProvider.partner;

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true, // This is KEY to go under the status bar
      // appBar: AppBar(
      //   title: const Text('Profile'),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: Stack(
        children: [
          TopImageSection(
            imageUrl: samplePartnerImage,
            height: size.height * 0.375,
          ),

          Column(
            children: [
              SizedBox(height: size.height * .08),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ],
              ),
              PaddedContainer(
                child: Column(
                  children: [
                    SizedBox(height: size.height * .235),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  "${partner?.firstName ?? ""} ${partner?.lastName ?? ""}",
                                  size: size.height * .024,
                                  weight: FontWeight.bold,
                                  color: AppColors.appBlack.withValues(
                                    alpha: .9,
                                  ),
                                ),
                                CustomText(
                                  partner?.jobTitle ?? "",
                                  size: size.height * .0170,
                                  color: AppColors.appBlack.withValues(
                                    alpha: 1,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                CustomText(""),
                                Row(
                                  children: [
                                    Container(
                                      height: size.width * .022,
                                      width: size.width * .022,
                                      decoration: BoxDecoration(
                                        color: AppColors.appBlack.withValues(alpha: .7),
                                        borderRadius: BorderRadius.circular(
                                          size.width * .011,
                                        ),
                                      ),
                                    ),
SizedBox(width: size.width * .02),
                                    CustomText(
                                      "${partner?.yearsOfExperience ?? ""} Years Experience",
                                      size: size.height * .0170,
                                      color: AppColors.appBlack.withValues(
                                        alpha: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * .02),
                    Row(
                      children: [
                        Column(children: [TitleText(title: "Bio")]),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            partner?.bio ?? "",
                            size: size.height * .016,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * .03),
                    Row(
                      children: [
                        Column(
                          children: [TitleText(title: "Contact Information")],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomText(
                          "No available basic info, Kindly update your profile",
                          size: size.height * .016,
                          height: 1.5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
