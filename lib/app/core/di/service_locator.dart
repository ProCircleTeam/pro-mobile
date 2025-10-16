import 'package:get_it/get_it.dart';
import 'package:pro_mobile/app/core/client/app_client.dart';
import 'package:pro_mobile/data/remote/auth/auth_service_impl.dart';
import 'package:pro_mobile/data/remote/auth/auth_service.dart';
import 'package:pro_mobile/data/remote/calendar/calendar_service.dart';
import 'package:pro_mobile/data/remote/calendar/calendar_service_impl.dart';
import 'package:pro_mobile/data/remote/goal/goal_service.dart';
import 'package:pro_mobile/data/remote/goal/goal_service_impl.dart';
import 'package:pro_mobile/data/remote/notification/notification_service.dart';
import 'package:pro_mobile/data/remote/notification/notification_service_impl.dart';
import 'package:pro_mobile/data/remote/user/user_service.dart';
import 'package:pro_mobile/data/remote/user/user_service_imple.dart';

GetIt sl = GetIt.instance;

Future<void> setUpServiceLocator() async {
  sl.registerSingleton<AppClient>(AppClient());
  sl.registerLazySingleton<AuthService>(() => AuthServiceImpl(sl.get()));
  sl.registerLazySingleton<GoalService>(() => GoalServiceImpl(sl.get()));
  sl.registerLazySingleton<UserService>(() => UserServiceImpl(sl.get()));
  sl.registerLazySingleton<CalendarService>(() => CalendarServiceImpl(sl.get()));
  sl.registerLazySingleton<NotificationService>(() => NotificationServiceImpl(sl.get()));
}