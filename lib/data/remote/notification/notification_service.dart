import 'package:dio/dio.dart';

abstract class NotificationService {
  Future<Response?> fetchUserNotifications();
}
