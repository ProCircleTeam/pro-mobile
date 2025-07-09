import 'package:get_it/get_it.dart';
import 'package:pro_mobile/app/core/client/app_client.dart';
import 'package:pro_mobile/data/remote/auth/auth_service_impl.dart';
import 'package:pro_mobile/data/remote/auth/auth_service.dart';
import 'package:pro_mobile/data/remote/goal/goal_service.dart';
import 'package:pro_mobile/data/remote/goal/goal_service_impl.dart';

GetIt sl = GetIt.instance;

Future<void> setUpServiceLocator() async {
  sl.registerSingleton<AppClient>(AppClient());
  sl.registerLazySingleton<AuthService>(() => AuthServiceImpl(sl.get()));
  sl.registerLazySingleton<GoalService>(() => GoalServiceImpl(sl.get()));
}