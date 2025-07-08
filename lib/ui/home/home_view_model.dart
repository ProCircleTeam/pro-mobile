import 'package:pro_mobile/app/core/failure/failure.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/data/remote/goal/goal_service.dart';
import 'package:pro_mobile/domain/models/goal_model.dart';
import 'package:pro_mobile/providers/goal_provider.dart';
import 'package:pro_mobile/ui/base/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  final GoalService goalService;
  final GoalProvider goalProvider;
  HomeViewModel({required this.goalService, required this.goalProvider});

  bool _isGettingGoal = false;
  bool get isGettingGoal => _isGettingGoal;
  set isGettingGoal(bool val) {
    _isGettingGoal = val;
    notifyListeners();
  }

  Future<void> getUserWeeklyGoal({
    required int goalId,
    required Function(String e) onError,
  }) async {
    try {
      GoalModel? goal = await goalService.getGoalById(goalId);
      if (goal != null) {
        goalProvider.goals = goal;
        print("This is the weekly goals ======================> ");
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
}
