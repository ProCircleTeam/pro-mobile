import 'package:flutter/widgets.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/data/local/goals_storage.dart';
import 'package:pro_mobile/ui/base/base_view_model.dart';

class GoalViewModel extends BaseViewModel {
  TextEditingController goalController = TextEditingController();
  List<String> _goals = [];

  List<String> get goals => _goals;

  void addGoal(String val) {
    _goals = [..._goals, val];
    notifyListeners();
  }

  void updateGoal({required String goal, required int index}) {
    _goals[index] = goal;
    notifyListeners();
  }

  void deletGoal({required String goal, required int index}) {
    goals.removeAt(index);
    notifyListeners();
  }

  List<Color> goalColors = [
    AppColors.goalBorderColor1,
    AppColors.goalBorderColor2,
    AppColors.goalBorderColor3,
  ];

  Future<void> init() async {
    List<String> savedGoals = await GoalStorage().loadGoals();
    _goals = savedGoals;
    notifyListeners();
  }
}
