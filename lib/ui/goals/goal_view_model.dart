import 'package:flutter/widgets.dart';
import 'package:pro_mobile/app/core/failure/failure.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/data/local/goals_storage.dart';
import 'package:pro_mobile/data/remote/goal/goal_service.dart';
import 'package:pro_mobile/domain/models/goal_model.dart';
import 'package:pro_mobile/providers/goal_provider.dart';
import 'package:pro_mobile/ui/base/base_view_model.dart';

class GoalViewModel extends BaseViewModel {
  final GoalProvider goalProvider;
  final GoalService goalService;
  GoalViewModel({required this.goalService, required this.goalProvider});

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

  bool _isCreatingGoal = false;
  bool get isCreatingGoal => _isCreatingGoal;
  set isCreatingGoal(bool val) {
    _isCreatingGoal = val;
    notifyListeners();
  }

  bool _isGettingGoal = false;
  bool get isGettingGoal => _isGettingGoal;
  set isGettingGoal(bool val) {
    _isGettingGoal = val;
    notifyListeners();
  }

  bool _isUpdatingGoal = false;
  bool get isUpdatingGoal => _isUpdatingGoal;
  set isUpdatingGoal(bool val) {
    _isUpdatingGoal = val;
    notifyListeners();
  }

  Future<void> init() async {
    List<String> savedGoals = await GoalStorage().loadGoals();
    _goals = savedGoals;
    notifyListeners();
  }

  Future<void> createGoalsOnServer({
    required List<String> goals,
    required Function(String s) onSuccess,
    required Function(String e) onError,
  }) async {
    try {
      isCreatingGoal = true;
      await goalService.createGoal(goals);
      isCreatingGoal = false;
      onSuccess("Goal created Successfully");
    } on Failure catch (e) {
      isCreatingGoal = false;
      onError(e.errorMessage);
    } catch (e) {
      isCreatingGoal = false;
      onError(ErrorText.generic);
    }
  }

  Future<void> getGoalById({
    required int goalId,
    required Function(String e) onError,
  }) async {
    try {
      isGettingGoal = true;
      GoalModel? goal = await goalService.getGoalById(goalId);
      if (goal != null) {
        goalProvider.goals = goal;
      } else {
        throw Failure("Unable to fetch goals");
      }
      isGettingGoal = false;
    } on Failure catch (e) {
      isGettingGoal = false;
      onError(e.errorMessage);
    } catch (e) {
      isGettingGoal = false;
      onError(ErrorText.generic);
    }
  }

  Future<void> updateGoalsOnServer({
    required List<String> goals,
    required Function(String s) onSuccess,
    required Function(String e) onError,
    required int goalId,
  }) async {
    try {
      isUpdatingGoal = true;
      await goalService.updateGoal(goals: goals, id: goalId);
      isUpdatingGoal = false;
      onSuccess("Goal updated Successfully");
    } on Failure catch (e) {
      isUpdatingGoal = false;
      onError(e.errorMessage);
    } catch (e) {
      isUpdatingGoal = false;
      onError(ErrorText.generic);
    }
  }
}
