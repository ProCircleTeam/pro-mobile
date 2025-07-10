import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pro_mobile/app/core/di/service_locator.dart';
import 'package:pro_mobile/app/routes/app_router.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/data/local/goals_storage.dart';
import 'package:pro_mobile/data/remote/goal/goal_service.dart';
import 'package:pro_mobile/providers/goal_provider.dart';
import 'package:pro_mobile/ui/base/base_view.dart';
import 'package:pro_mobile/ui/goals/goal_view_model.dart';
import 'package:pro_mobile/ui/utils/flush_bar/app_flush_bar.dart';
import 'package:pro_mobile/ui/widgets/action_button.dart';
import 'package:pro_mobile/ui/widgets/custom_app_bar.dart';
import 'package:pro_mobile/ui/widgets/custom_bottom_modal.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/padded_container.dart';
import 'package:pro_mobile/ui/widgets/warning_bar.dart';
import 'package:provider/provider.dart';

class GoalsHomePage extends StatefulWidget {
  const GoalsHomePage({super.key});

  @override
  State<GoalsHomePage> createState() => _GoalsHomePageState();
}

class _GoalsHomePageState extends State<GoalsHomePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    GoalProvider goalProvider = Provider.of<GoalProvider>(context);

    final size = MediaQuery.of(context).size;
    final goalBorderSide = BorderSide(
      color: Colors.grey.withValues(alpha: .5),
      width: 1.0,
    );

    final random = Random();
    final args = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: customAppBer("Upload  Goals"),
      body: BaseView<GoalViewModel>(
        model: GoalViewModel(
          goalProvider: goalProvider,
          goalService: sl.get<GoalService>(),
        ),
        onModelReady: (model) async {
          List<String>? goalsFromDatabase =
              args != null ? goalProvider.goals?.goals : null;

          await model.init(goalsFromDatabase);
        },
        builder: (context, model, _) {
          bool isGoalFromDataBase = args == null ? false : true;

          return PaddedContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: size.height - (size.height * .37),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        WarningBar(),
                        SizedBox(height: size.height * 0.04),
                        Row(
                          children: [
                            CustomText(
                              "Goals",
                              weight: FontWeight.bold,
                              size: size.height * .022,
                            ),
                            SizedBox(width: size.width * .02),
                            CustomText(
                              "(${model.goals.length} of 5)",
                              size: size.height * .022,
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * .014),
                        Slidable(child: Column(children: [
                            
                          ],
                        )),
                        ...model.goals.map((goal) {
                          return Slidable(
                            key: ValueKey(goal), // Must be unique
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) {
                                    if (goal.isNotEmpty) {
                                      int goalIndex = model.goals.indexOf(goal);
                                      model.deletGoal(
                                        goal: goal,
                                        index: goalIndex,
                                      );

                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(content: Text('Goal Deleted')),
                                      );
                                    }
                                  },
                                  backgroundColor: Colors.white,
                                  icon: Icons.delete_outline,
                                  flex: 2,
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                handleGoalViewingAndEditing(
                                  context: context,
                                  size: size,
                                  formKey: _formKey,
                                  model: model,
                                  goalToEdit: goal,
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: size.width,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * .04,
                                      vertical: size.height * .02,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color:
                                              model.goalColors[random.nextInt(
                                                9,
                                              )],
                                          width: 5.0,
                                        ),
                                        top: goalBorderSide,
                                        right: goalBorderSide,
                                        bottom: goalBorderSide,
                                      ),
                                    ),
                                    child: CustomText(
                                      goal,
                                      size: size.height * .016,
                                    ),
                                  ),
                                  SizedBox(height: size.height * .017),
                                ],
                              ),
                            ),
                          );
                        }),
                        if (model.goals.length < 5)
                          Row(
                            children: [
                              InkWell(
                                child: CustomText(
                                  "+ Add  Goal",
                                  size: size.height * .019,
                                  weight: FontWeight.bold,
                                  color: AppColors.primary.withValues(
                                    alpha: .65,
                                  ),
                                ),
                                onTap: () {
                                  handleGoalViewingAndEditing(
                                    context: context,
                                    size: size,
                                    formKey: _formKey,
                                    model: model,
                                  );
                                },
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    ActionButton(
                      title: isGoalFromDataBase == false ? "Submit" : "Update",
                      isLoading:
                          isGoalFromDataBase == false
                              ? model.isCreatingGoal
                              : model.isUpdatingGoal,
                      onTap:
                          model.goals.isEmpty
                              ? () {
                                AppFlushBar().showError(
                                  message:
                                      "No goal(s) to submit, kindly add goal(s) to proceed",
                                  context: context,
                                );
                              }
                              : () async {
                                if (isGoalFromDataBase) {
                                    await model.updateGoalsOnServer(
                                    goalId: goalProvider.goals!.id,
                                    goals: model.goals,
                                    onSuccess: (s) async {
                                      AppFlushBar().showSuccess(
                                        message: s,
                                        context: context,
                                      );
                                      await GoalStorage().clearGoals();
                                      Future.delayed(Duration(seconds: 3), () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          AppRouter.home,
                                        );
                                      });
                                    },
                                    onError: (e) {
                                      AppFlushBar().showError(
                                        message: e,
                                        context: context,
                                      );
                                    },
                                  );
                                } else {  await model.createGoalsOnServer(
                                    goals: model.goals,
                                    onSuccess: (s) async {
                                      AppFlushBar().showSuccess(
                                        message: s,
                                        context: context,
                                      );
                                      await GoalStorage().clearGoals();
                                      Future.delayed(Duration(seconds: 3), () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          AppRouter.home,
                                        );
                                      });
                                    },
                                    onError: (e) {
                                      AppFlushBar().showError(
                                        message: e,
                                        context: context,
                                      );
                                    },
                                  );
                                }
                              },
                      bgColor:
                          model.goals.isEmpty
                              ? AppColors.primary.withValues(alpha: .4)
                              : AppColors.primary,
                    ),
                    SizedBox(height: size.height * 0.015),
                    if(!isGoalFromDataBase)
                    InkWell(
                      onTap: () async {
                        if (model.goals.isEmpty) {
                          AppFlushBar().showError(
                            message:
                                "No goal(s) to save, kindly add goal to proceed",
                            context: context,
                          );
                        } else {
                          await GoalStorage().saveGoals(model.goals);
                          AppFlushBar().showSuccess(
                            message: "Goals saved successfully",
                            context: context,
                          );
                          Future.delayed(Duration(seconds: 4), () {
                            Navigator.pop(context);
                          });
                        }
                      },
                      child: CustomText(
                        "Save and Continue Later",
                        size: size.height * .017,
                        weight: FontWeight.bold,
                        color:
                            model.goals.isEmpty
                                ? AppColors.tinGrey
                                : AppColors.primary.withValues(alpha: .8),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void handleGoalViewingAndEditing({
  required BuildContext context,
  required Size size,
  required GlobalKey<FormState> formKey,
  required GoalViewModel model,
  String? goalToEdit,
}) {
  if (goalToEdit != null) {
    model.goalController.text = goalToEdit;
  }
  CustomBottomModal.show(
    context: context,
    isDismissible: false,
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .02,
        vertical: size.height * .02,
      ),
      child: SizedBox(
        width: size.width,
        height: size.height * .35,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  goalToEdit == null ? "Add Goal" : "Update Goal",
                  weight: FontWeight.bold,
                  size: size.height * .022,
                ),
                IconButton(
                  onPressed: () {
                    model.goalController.clear();
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close, size: size.height * .026),
                ),
              ],
            ),
            Form(
              key: formKey,
              child: TextFormField(
                controller: model.goalController,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: 'Enter goal',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Goal cannot be empty";
                  }
                  if (value.trim().length < 5) {
                    return "Goal must be at least 5 characters";
                  }
                  return null;
                },
              ),
            ),

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ActionButton(
                        title: "Cancel",
                        bgColor: AppColors.primary.withValues(alpha: .5),
                        onTap: () {
                          model.goalController.clear();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(width: size.width * .15),
                    Expanded(
                      child: ActionButton(
                        title: goalToEdit == null ? "Add" : "Update",
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            String goal = model.goalController.text;

                            if (goalToEdit != null) {
                              int indexOfGoalToEdit = model.goals.indexOf(
                                goalToEdit,
                              );
                              model.updateGoal(
                                goal: goal,
                                index: indexOfGoalToEdit,
                              );
                              model.goalController.clear();
                              Navigator.pop(context);
                              return;
                            }

                            if (model.goals.length > 4) {
                              Navigator.pop(context);
                              AppFlushBar().showError(
                                message: "Maximum goals reached",
                                context: context,
                              );
                            } else if (goal.isNotEmpty) {
                              model.addGoal(goal);
                              model.goalController.clear();

                              if (model.goals.length > 4) {
                                AppFlushBar().showSuccess(
                                  message: "Maximum goals reached",
                                  context: context,
                                );
                                Future.delayed(Duration(seconds: 4), () {
                                  Navigator.pop(context);
                                });
                              } else {
                                AppFlushBar().showSuccess(
                                  message: "Goal Added",
                                  context: context,
                                );
                              }
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * .02),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
