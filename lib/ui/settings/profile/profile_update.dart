import 'package:flutter/material.dart';
import 'package:pro_mobile/app/routes/app_router.dart';
import 'package:pro_mobile/ui/settings/widgets/settings_tile.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/padded_container.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({super.key});

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText("Update Profile", weight: FontWeight.bold),
      ),
      body: PaddedContainer(
        child: Column(
          children: [
            SettingsTile(
              title: "Personal Info",
              icon: Icons.person_2_outlined,
              onTap: () {
                Navigator.pushNamed(context, AppRouter.personalInfoUpdatePage);
              },
            ),
            SettingsTile(
              title: "Professional Info",
              icon: Icons.photo_camera_front_outlined,
              onTap: () {
                Navigator.pushNamed(context, AppRouter.professionalInfoUpdatePage);
              },
            ),
            SettingsTile(
              title: "Goals and Interest",
              icon: Icons.interests_outlined,
              onTap: () {
                Navigator.pushNamed(context, AppRouter.goalsAndInterest);
              },
            ),
            SettingsTile(
              title: "Engagement",
              icon: Icons.energy_savings_leaf_outlined,
              showDivider: false,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
