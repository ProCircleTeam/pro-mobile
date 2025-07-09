import 'package:dio/dio.dart';
import 'package:pro_mobile/app/core/client/app_client.dart';
import 'package:pro_mobile/app/core/client/header.dart';
import 'package:pro_mobile/app/core/endpoints/endpoints.dart';
import 'package:pro_mobile/data/remote/goal/goal_service.dart';
import 'package:pro_mobile/domain/models/goal_model.dart';

class GoalServiceImpl implements GoalService {
  final AppClient appClient;
  GoalServiceImpl(this.appClient);

  @override
  Future<GoalModel?> createGoal(List<String> goals) async {
    const url = Endpoints.createGoal;
    Map<String, dynamic> data = {"goals": goals};
    final header = await getAppHeader(isTokenRequired: true);
    Response res = await appClient.post(url, data, headers: header);

    GoalModel goal = GoalModel.fromJson(res.data["data"]);
    return goal;
  }

  @override
  Future<GoalModel?> updateGoal({
    required List<String> goals,
    required int id,
  }) async {
    String url = Endpoints.updateGoal(id);
    Map<String, dynamic> data = {"goals": goals};
    final header = await getAppHeader(isTokenRequired: true);
    Response? res = await appClient.put(url, data, headers: header);

    GoalModel? goal = GoalModel.fromJson(res?.data["data"]);
    return goal;
  }

  @override
  Future<GoalModel?> getGoalById(int id) async {
    String url = Endpoints.getGoalById(id);
    final header = await getAppHeader(isTokenRequired: true);

    Response? res = await appClient.get(url, headers: header);
    return GoalModel.fromJson(res?.data["data"]);
  }
}
