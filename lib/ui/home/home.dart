import 'package:flutter/material.dart';
import 'package:pro_mobile/app/core/di/service_locator.dart';
import 'package:pro_mobile/app/routes/app_router.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/data/local/secure_storage.dart';
import 'package:pro_mobile/data/remote/goal/goal_service.dart';
import 'package:pro_mobile/domain/models/user_model.dart';
import 'package:pro_mobile/providers/goal_provider.dart';
import 'package:pro_mobile/providers/user_provider.dart';
import 'package:pro_mobile/ui/auth/signin.dart';
import 'package:pro_mobile/ui/base/base_view.dart';
import 'package:pro_mobile/ui/home/home_view_model.dart';
import 'package:pro_mobile/ui/home/widget.dart/accountability_partner_card.dart';
import 'package:pro_mobile/ui/home/widget.dart/goal_listing.dart';
import 'package:pro_mobile/ui/home/widget.dart/reminders_card.dart';
import 'package:pro_mobile/ui/home/widget.dart/streak_card.dart';
import 'package:pro_mobile/ui/utils/flush_bar/app_flush_bar.dart';
import 'package:pro_mobile/ui/widgets/action_button.dart';
import 'package:pro_mobile/ui/widgets/app_text_style.dart';
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
    UserModel user = userProvider.user!;
    final size = MediaQuery.of(context).size;

    List<String> uploadedGoals =
        goalProvider.goals?.goals ??
        ["You have no goal set for this week, Kindly create goal to continue"];

    return Scaffold(
      body: BaseView<HomeViewModel>(
        model: HomeViewModel(
          goalService: sl.get<GoalService>(),
          goalProvider: goalProvider,
        ),
        onModelReady: (model) {
          model.getUserWeeklyGoalByDate((e) {
            AppFlushBar().showError(message: e, context: context);
          });
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
                await model.getUserWeeklyGoalByDate((e) {
                  AppFlushBar().showError(message: e, context: context);
                });
              },
              child: SizedBox(
                height: size.height,
                child: Column(
                  children: [
                    SpacingWidget(degree: .05),
                    ListTile(
                      leading: Container(
                        height: size.width * .11,
                        width: size.width * .11,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(
                            size.width * .055,
                          ),
                          image: DecorationImage(
                            image: AssetImage(PNGImageUrl.sampleProfilePix2),
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
                            onTap: () {},
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
                              onTap: () {
                               
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
                                  size: 16,
                                ),
                                SizedBox(),
                              ],
                            ),
                            SpacingWidget(degree: .01),
                            GoalListing(
                              isFetchingGoals: model.isGettingGoal,
                              goals:
                                  uploadedGoals.length > 2
                                      ? uploadedGoals.take(2).toList()
                                      : uploadedGoals,
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
                                    noOfGoalsSet: 3,
                                    completedGoals: 2,
                                  ),
                                  StreakCard(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * .175,
                              child: GridView.count(
                                crossAxisCount: 2,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(size.width * .02),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                children: [RemindersCard(), RemindersCard()],
                              ),
                            ),
                            SizedBox(
                              height: size.height * .175,
                              child: GridView.count(
                                crossAxisCount: 2,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(size.width * .02),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                children: [RemindersCard(), RemindersCard()],
                              ),
                            ),
                            SizedBox(
                              height: size.height * .175,
                              child: GridView.count(
                                crossAxisCount: 2,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(size.width * .02),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                children: [RemindersCard(), RemindersCard()],
                              ),
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
