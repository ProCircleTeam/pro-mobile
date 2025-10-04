import 'package:pro_mobile/app/core/failure/failure.dart';
import 'package:pro_mobile/data/remote/notification/notification_service.dart';
import 'package:pro_mobile/ui/base/base_view_model.dart';
import 'package:pro_mobile/ui/utils/app_logger.dart';

class NotificationViewModel extends BaseViewModel {
  final NotificationService notificationService;
  NotificationViewModel(this.notificationService);

  Future<void> fetchUserNotifications() async {
    try {
      var res = await notificationService.fetchUserNotifications();
      print("Here is the console =======================> $res");
    } on Failure catch (e) {
      AppLogger.log("Error ==================> ${e.errorMessage}");
    } catch (e) {
      AppLogger.log("Error ==================> $e");
    }
  }
}
