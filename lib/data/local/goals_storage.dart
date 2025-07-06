import 'package:shared_preferences/shared_preferences.dart';

class GoalStorage {
  static const String _goalsKey = 'user_goals';

  Future<void> saveGoals(List<String> goals) async {
    final preference = await SharedPreferences.getInstance();
    await preference.setStringList(_goalsKey, goals);
  }

  Future<List<String>> loadGoals() async {
    final preference = await SharedPreferences.getInstance();
    return preference.getStringList(_goalsKey) ?? [];
  }

  Future<void> clearGoals() async {
    final preference = await SharedPreferences.getInstance();
    await preference.remove(_goalsKey);
  }
}
