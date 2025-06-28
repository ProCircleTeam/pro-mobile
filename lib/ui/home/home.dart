import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/data/local/secure_storage.dart';
import 'package:pro_mobile/domain/models/user_model.dart';
import 'package:pro_mobile/providers/user_provider.dart';
import 'package:pro_mobile/ui/auth/signin.dart';
import 'package:pro_mobile/ui/home/widget.dart/accountability_partner_card.dart';
import 'package:pro_mobile/ui/home/widget.dart/goal_listing.dart';
import 'package:pro_mobile/ui/home/widget.dart/reminders_card.dart';
import 'package:pro_mobile/ui/home/widget.dart/streak_card.dart';
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
  int _currentIndex = 0;

  final List<Widget> pages = [
    Center(child: CustomText('Home')),
    Center(child: CustomText('Event')),
    Center(child: CustomText('Add Goal')),
    Center(child: CustomText('Settings')),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    UserModel user = userProvider.user!;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: size.height * .03,
          left: size.width * .035,
          right: size.width * .035,
        ),
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
                    borderRadius: BorderRadius.circular(size.width * .055),
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
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Logout",
                                          textAlign: TextAlign.start,
                                          style: AppTextStyle.title(
                                            fontSize: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 30),
                                    Text(
                                      "Are you sure you want to log out?",
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.subTitle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: ActionButton(
                                            title: "Canceal",
                                            bgColor: AppColors.primary
                                                .withOpacity(.8),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: ActionButton(
                                            title: "Continue",
                                            bgColor: AppColors.red,
                                            onTap: () async {
                                              SecureStorageService storage =
                                                  SecureStorageService();
                                              await storage.clearAll();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) => SignInPage(),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SpacingWidget(degree: .05, isVertical: false),
                    Expanded(
                      child: ActionButton(
                        verticalPadding: size.height * .013,
                        title: "",
                        bgColor: AppColors.secondary,
                        title2: Icon(
                          Icons.task_alt_outlined,
                          color: Colors.white,
                        ),
                        onTap: () {},
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
                        goals: [
                          "Build a strong portfolio",
                          "Post twice on LinkedIn this week",
                        ],
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

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFEDEFF1),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.tinGrey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Add Goals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
