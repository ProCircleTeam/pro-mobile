import 'package:flutter/material.dart';
import 'package:pro_mobile/domain/models/goal_model.dart';

class GoalProvider extends ChangeNotifier {
  GoalModel? _goals;
  GoalModel? get goals => _goals;
  set goals(GoalModel? val) {
    _goals = val;
    notifyListeners();
  }
}
