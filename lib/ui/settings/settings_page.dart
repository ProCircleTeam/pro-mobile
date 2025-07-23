import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/data/local/secure_storage.dart';
import 'package:pro_mobile/ui/auth/signin.dart';
import 'package:pro_mobile/ui/settings/widgets/settings_tile.dart';
import 'package:pro_mobile/ui/widgets/action_button.dart';
import 'package:pro_mobile/ui/widgets/app_text_style.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/padded_container.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: CustomText("Settings", weight: FontWeight.bold),
        leading: SizedBox(),
      ),
      body: PaddedContainer(
        child: Column(
          children: [
            SettingsTile(
              title: "Profile",
              icon: Icons.person_2_outlined,
              onTap: () {},
            ),
            SettingsTile(
              title: "Notification",
              icon: Icons.person_2_outlined,
              onTap: () {},
            ),
            SettingsTile(
              title: "Change Password",
              icon: Icons.person_2_outlined,
              onTap: () {},
            ),
            SettingsTile(
              title: "Help & FAQ",
              icon: Icons.person_2_outlined,
              onTap: () {},
            ),
            SettingsTile(
              title: "Delete Account",
              icon: Icons.person_2_outlined,
              onTap: () {},
            ),
            SettingsTile(
              title: "Log out",
              icon: Icons.person_2_outlined,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(size.height * .01)),
                      ),
                      content: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.015,
                        ),
                        width: size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  "Confirm Log out",
                                  textAlign: TextAlign.center,
                                  weight: FontWeight.bold,
                                  size: size.height * .019,
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * .015),
                            CustomText(
                              "Are you sure you want to log out?",
                              size: size.height * 0.018,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: size.height * .04),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: ActionButton(
                                    title: "Cancel",
                                    bgColor: AppColors.captionColor,
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                SizedBox(width: size.width * 0.04),
                                Expanded(
                                  child: ActionButton(
                                    title: "Log out",
                                    bgColor: Colors.white,
                                    textColor: AppColors.red,
                                    borderColor: AppColors.red,
                                    onTap: () async {
                                      SecureStorageService storage =
                                          SecureStorageService();
                                      await storage.clearAll();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignInPage(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              showDivider: false,
            ),
          ],
        ),
      ),
    );
  }
}
