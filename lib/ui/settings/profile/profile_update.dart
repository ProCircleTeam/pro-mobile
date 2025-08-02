import 'package:flutter/material.dart';
import 'package:pro_mobile/app/core/di/service_locator.dart';
import 'package:pro_mobile/app/routes/app_router.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/data/remote/user/user_service.dart';
import 'package:pro_mobile/providers/user_provider.dart';
import 'package:pro_mobile/ui/base/base_view.dart';
import 'package:pro_mobile/ui/settings/profile/profile_view_model.dart';
import 'package:pro_mobile/ui/settings/widgets/settings_tile.dart';
import 'package:pro_mobile/ui/utils/flush_bar/app_flush_bar.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/padded_container.dart';
import 'package:provider/provider.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({super.key});

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    final size = MediaQuery.of(context).size;
    final iconWidth = size.width * .027;

    return Scaffold(
      appBar: AppBar(
        title: CustomText("Update Profile", weight: FontWeight.bold),
      ),
      body: BaseView<ProfileViewModel>(
        model: ProfileViewModel(sl.get<UserService>()),
        onModelReady: (model) async {
          await model.getUserProfileCompletionStatus((e) {
            AppFlushBar().showError(message: e, context: context);
          });
          await model.syncUserProfile(
            userProvider: userProvider,
            onError: (e) {
              AppFlushBar().showError(message: e, context: context);
            },
          );
        },
        builder: (context, model, _) {
          bool isGettingProfileInfoRead = model.isFetchingProfileStatus || model.isSyncingUserProfile ? true :false;

          return PaddedContainer(
            child: Column(
              children: [
                SettingsTile(
                  title: "Personal Info",
                  icon: Icons.person_2_outlined,
                  trailingWidget:
                      isGettingProfileInfoRead
                          ? SizedBox(
                            width: iconWidth,
                            height: iconWidth,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.richBlue,
                            ),
                          )
                          : model.isPersonalInfoCompleted
                          ? Icon(
                            Icons.check_circle,
                            color: AppColors.richBlue.withValues(alpha: .8),
                          )
                          : null,
                  onTap: () {
                    if (!isGettingProfileInfoRead) {
                      Navigator.pushNamed(
                        context,
                        AppRouter.personalInfoUpdatePage,
                      );
                    }
                  },
                ),
                SettingsTile(
                  title: "Professional Info",
                  icon: Icons.photo_camera_front_outlined,
                  trailingWidget:
                      isGettingProfileInfoRead
                          ? SizedBox(
                            width: iconWidth,
                            height: iconWidth,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.richBlue,
                            ),
                          )
                          : model.isProfessionalInfoCompleted
                          ? Icon(
                            Icons.check_circle,
                            color: AppColors.richBlue.withValues(alpha: .8),
                          )
                          : null,
                  onTap: () {
                    if (!isGettingProfileInfoRead) {
                      Navigator.pushNamed(
                        context,
                        AppRouter.professionalInfoUpdatePage,
                      );
                    }
                  },
                ),
                SettingsTile(
                  title: "Goals and Interest",
                  icon: Icons.interests_outlined,
                  trailingWidget:
                      isGettingProfileInfoRead
                          ? SizedBox(
                            width: iconWidth,
                            height: iconWidth,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.richBlue,
                            ),
                          )
                          : model.isGoalInfoCompleted
                          ? Icon(
                            Icons.check_circle,
                            color: AppColors.richBlue.withValues(alpha: .8),
                          )
                          : null,
                  onTap: () {
                    if (!isGettingProfileInfoRead) {
                      Navigator.pushNamed(context, AppRouter.goalsAndInterest);
                    }
                  },
                ),
                SettingsTile(
                  title: "Engagement",
                  icon: Icons.energy_savings_leaf_outlined,
                  trailingWidget:
                      isGettingProfileInfoRead
                          ? SizedBox(
                            width: iconWidth,
                            height: iconWidth,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.richBlue,
                            ),
                          )
                          : model.isEngagementInfoCompleted
                          ? Icon(
                            Icons.check_circle,
                            color: AppColors.richBlue.withValues(alpha: .8),
                          )
                          : null,
                  showDivider: false,
                  onTap: () {
                    if (!isGettingProfileInfoRead) {
                      Navigator.pushNamed(context, AppRouter.engagementPage);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
