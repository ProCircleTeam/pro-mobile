import 'package:pro_mobile/domain/models/goal_model.dart';

abstract class GoalService {
  Future<GoalModel?> createGoal(List<String> goals);
  Future<GoalModel?> updateGoal({required List<String> goals, required int id});
  Future<GoalModel?> getGoalById(int id);
}
