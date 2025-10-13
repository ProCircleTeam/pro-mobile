import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:pro_mobile/app/core/di/service_locator.dart';
import 'package:pro_mobile/app/routes/app_router.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/data/remote/goal/goal_service.dart';
import 'package:pro_mobile/data/remote/notification/notification_service.dart';
import 'package:pro_mobile/data/remote/user/user_service.dart';
import 'package:pro_mobile/domain/models/user_model.dart';
import 'package:pro_mobile/providers/goal_provider.dart';
import 'package:pro_mobile/providers/notification_provider.dart';
import 'package:pro_mobile/providers/user_provider.dart';
import 'package:pro_mobile/ui/base/base_view.dart';
import 'package:pro_mobile/ui/home/goal_modal_content.dart';
import 'package:pro_mobile/ui/home/home_view_model.dart';
import 'package:pro_mobile/ui/home/schedule_page.dart';
import 'package:pro_mobile/ui/home/widget.dart/accountability_partner_card.dart';
import 'package:pro_mobile/ui/home/widget.dart/goal_empty_state.dart';
import 'package:pro_mobile/ui/home/widget.dart/goal_listing.dart';
import 'package:pro_mobile/ui/home/widget.dart/prev_partner_tile.dart';
import 'package:pro_mobile/ui/home/widget.dart/reminders_card.dart';
import 'package:pro_mobile/ui/home/widget.dart/streak_card.dart';
import 'package:pro_mobile/ui/utils/enum/goals_enum.dart';
import 'package:pro_mobile/ui/utils/flush_bar/app_flush_bar.dart';
import 'package:pro_mobile/ui/widgets/action_button.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/spacing_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    GoalProvider goalProvider = Provider.of<GoalProvider>(context);
    NotificationProvider notificationProvider =
        Provider.of<NotificationProvider>(context);
    UserModel user = userProvider.user!;
    final size = MediaQuery.of(context).size;

    final bool hasReminder = false;
    final bool hasCommunityHighlight = false;

    List<String> previousPartners = [
      "Nature Okeosis",
      "Rita Malizzy",
      "Akeem Balogun",
      "Theo Fortune",
    ];

    List<String> sampleProfileImages = [
      StringConstants.sampleProfileImage2,
      StringConstants.sampleProfileImage5,
      StringConstants.sampleProfileImage4,
      StringConstants.sampleProfileImage3,
    ];

    List<String> uploadedGoals = goalProvider.goals?.goals ?? [];
    GoalStatusEnum status = GoalStatusEnum.inProgress;

    return Scaffold(
      body: BaseView<HomeViewModel>(
        model: HomeViewModel(
          goalService: sl.get<GoalService>(),
          userService: sl.get<UserService>(),
          notificationService: sl.get<NotificationService>(),
          goalProvider: goalProvider,
          userProvider: userProvider,
        ),
        onModelReady: (model) async {
          await model.getUserWeeklyGoalByDate((e) {});
          await model.fetchUserNotifications(notificationProvider);

          if (model.partnerId > 0) {
            await model.getPartner(
              partnerId: model.partnerId,
              onError: (e) {
                AppFlushBar().showError(message: e, context: context);
              },
            );
          }
        },
        builder: (context, model, _) {
          return Container(
            padding: EdgeInsets.only(
              top: size.height * .03,
              left: size.width * .035,
              right: size.width * .035,
            ),
            child: RefreshIndicator(
              onRefresh: () async {
                await model.getUserWeeklyGoalByDate((e) {});
                await model.getPartner(
                  partnerId: model.partnerId,
                  onError: (e) {},
                );
                await model.fetchUserNotifications(notificationProvider);
              },
              child: SizedBox(
                height: size.height,
                child: Column(
                  children: [
                    SpacingWidget(degree: .05),
                    ListTile(
                      leading: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRouter.profile);
                        },
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl:
                                user.profilePhoto ??
                                StringConstants.sampleProfileImage,
                            placeholder:
                                (context, url) => SizedBox(
                                  width: size.width * .09,
                                  height: size.width * .09,
                                  child: CircularProgressIndicator(),
                                ),
                            fit: BoxFit.cover,
                            errorWidget:
                                (context, url, error) => Icon(Icons.error),
                            width: size.width * .11,
                            height: size.width * .11,
                          ),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            "Hello, ${user.username}",
                            size: 16,
                            weight: FontWeight.bold,
                            color: AppColors.appBlack,
                          ),
                          CustomText(
                            "@${user.username}",
                            size: 12,
                            weight: FontWeight.bold,
                            color: AppColors.lightBlack,
                          ),
                        ],
                      ),
                      trailing: Stack(
                        children: [
                          Positioned(
                            left: 16,
                            bottom: 15,
                            child: Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRouter.notificationPage,
                              );
                            },
                            child: Icon(Icons.notifications_none, size: 25),
                          ),
                        ],
                      ),
                    ),
                    SpacingWidget(degree: .02),
                    SizedBox(
                      width: size.width,
                      child: Row(
                        children: [
                          Expanded(
                            child: ActionButton(
                              verticalPadding: size.height * .013,
                              title: "",
                              title2: Icon(Icons.add, color: Colors.white),

                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRouter.goalsHomePage,
                                );
                              },
                            ),
                          ),
                          SpacingWidget(degree: .05, isVertical: false),
                          Expanded(
                            child: ActionButton(
                              verticalPadding: size.height * .013,
                              bgColor: AppColors.secondary,
                              title: "",
                              title2: Icon(
                                Icons.task_alt_outlined,
                                color: Colors.white,
                              ),
                              onTap: () async {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => WeeklySchedulePage()));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * .67,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SpacingWidget(degree: .04),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  "This Week's Goal",
                                  weight: FontWeight.bold,
                                  size: size.height * .019,
                                ),
                                SizedBox(),
                              ],
                            ),
                            SpacingWidget(degree: .01),
                            uploadedGoals.isEmpty
                                ? GoalEmptyState()
                                : GoalListing(
                                  isFetchingGoals: model.isGettingGoal,
                                  goals:
                                      uploadedGoals.length > 2
                                          ? uploadedGoals.take(2).toList()
                                          : uploadedGoals,
                                  onSeeAllTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        final size =
                                            MediaQuery.of(context).size;

                                        return AlertDialog(
                                          contentPadding: EdgeInsets.all(
                                            size.width * .035,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                size.height * .01,
                                              ),
                                            ),
                                          ),
                                          content: ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxHeight: size.height * 0.7,
                                              maxWidth: size.width * 0.9,
                                            ),
                                            child: GoalModalContent(
                                              status: status,
                                              goals: uploadedGoals,
                                              title:
                                                  status ==
                                                          GoalStatusEnum
                                                              .inProgress
                                                      ? "This Week's Goal"
                                                      : "Goal 01",
                                              onEditGoal: () {
                                                Navigator.pop(context);
                                                Navigator.pushNamed(
                                                  context,
                                                  AppRouter.goalsHomePage,
                                                  arguments:
                                                      "Data is from database",
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                            SpacingWidget(degree: .01),
                            SizedBox(
                              height: size.height * .175,
                              child: GridView.count(
                                crossAxisCount: 2,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(size.width * .02),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                children: [
                                  AccountabilityPartnerCard(
                                    partner: model.accountabilityPartner,
                                    noOfGoalsSet: 3,
                                    completedGoals: 2,
                                    onTap: () {
                                      if (model.accountabilityPartner != null) {
                                        Navigator.pushNamed(
                                          context,
                                          AppRouter.partnerProfilePage,
                                        );
                                      }
                                    },
                                  ),
                                  StreakCard(hasStreak: false),
                                ],
                              ),
                            ),
                            if (hasCommunityHighlight == true ||
                                hasReminder == true)
                              SizedBox(
                                height: size.height * .175,
                                child: GridView.count(
                                  crossAxisCount: 2,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.all(size.width * .02),
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  children: [
                                    RemindersCard(onTap: () {}),
                                    RemindersCard(onTap: () {}),
                                  ],
                                ),
                              ),
                            SpacingWidget(degree: .04),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  "Previous Partners",
                                  weight: FontWeight.bold,
                                  size: size.height * .017,
                                ),
                                CustomText("See all", size: size.height * .016),
                              ],
                            ),
                            SpacingWidget(degree: .02),
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: previousPartners.length,
                              itemBuilder: (context, i) {
                                return Column(
                                  children: [
                                    PrevPartnerTile(
                                      name: previousPartners[i],
                                      imageUrl: sampleProfileImages[i],
                                    ),
                                    SpacingWidget(degree: .02),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
