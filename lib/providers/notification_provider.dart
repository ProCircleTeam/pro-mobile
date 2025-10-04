import 'package:flutter/material.dart';
import 'package:pro_mobile/domain/models/notification_item_model.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationItemModel> _notifications = [];
  List<NotificationItemModel> get notifications => _notifications;
  set notifications(List<NotificationItemModel> val) {
    _notifications = val;
    notifyListeners();
  }
}
