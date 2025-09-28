import 'package:pro_mobile/app/core/failure/failure.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/data/remote/goal/goal_service.dart';
import 'package:pro_mobile/data/remote/user/user_service.dart';
import 'package:pro_mobile/domain/models/goal_model.dart';
import 'package:pro_mobile/domain/models/user_model.dart';
import 'package:pro_mobile/providers/goal_provider.dart';
import 'package:pro_mobile/providers/user_provider.dart';
import 'package:pro_mobile/ui/base/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  final GoalService goalService;
  final UserService userService;
  final GoalProvider goalProvider;
  final UserProvider userProvider;
  HomeViewModel({
    required this.goalService,
    required this.userService,
    required this.userProvider,
    required this.goalProvider,
  });

  bool _isGettingGoal = false;
  bool get isGettingGoal => _isGettingGoal;
  set isGettingGoal(bool val) {
    _isGettingGoal = val;
    notifyListeners();
  }

  bool _isGettingPartner = false;
  bool get isGettingPartner => _isGettingPartner;
  set isGettingPartner(bool val) {
    _isGettingPartner = val;
    notifyListeners();
  }

  bool _isGettingGoalsByDate = false;
  bool get isGettingGoalsByDate => _isGettingGoalsByDate;
  set isGettingGoalsByDate(bool val) {
    _isGettingGoalsByDate = val;
    notifyListeners();
  }

  int _partnerId = -1;
  int get partnerId => _partnerId;
  set partnerId(int val) {
    _partnerId = val;
    notifyListeners();
  }

  UserModel? _accountabilityPartner;
  UserModel? get accountabilityPartner => _accountabilityPartner;
  set accountabilityPartner(UserModel? val) {
    _accountabilityPartner = val;
    notifyListeners();
  }

  Future<void> getPartner({
    required int partnerId,
    required Function(String e) onError,
  }) async {
    try {
      isGettingPartner = true;
      UserModel? partner = await userService.getUserById(partnerId);
      accountabilityPartner = partner;

      if (partner != null) {
        userProvider.partner = partner;
      } else {
        throw Failure("Unable to fetch this week's paired partner");
      }
      isGettingPartner = false;
    } on Failure catch (e) {
      isGettingPartner = false;
      onError(e.errorMessage);
    } catch (e) {
      isGettingPartner = false;
      onError(ErrorText.generic);
    }
  }

  Future<void> getUserWeeklyGoal({
    required int goalId,
    required Function(String e) onError,
  }) async {
    try {
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

  Future<void> getUserWeeklyGoalByDate(Function(String e) onError) async {
    try {
      isGettingGoalsByDate = true;
      DateTime date = DateTime.now();
      String dateToPass = date.toString().split(" ")[0];

      GoalModel? goal = await goalService.getWeeklyGoalByDate(dateToPass);

      if (goal != null) {
        goalProvider.goals = goal;
        partnerId = goal.pairedWith;
      } else {
        throw Failure("Unable to fetch goals");
      }
      isGettingGoalsByDate = false;
    } on Failure catch (e) {
      isGettingGoalsByDate = false;
      onError(e.errorMessage);
    } catch (e) {
      isGettingGoalsByDate = false;
      onError(ErrorText.generic);
    }
  }
}
