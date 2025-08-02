import 'package:flutter/material.dart';
import 'package:pro_mobile/domain/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;
  set user(UserModel? val) {
    _user = val;
    notifyListeners();
  }

  UserModel? _partner;
  UserModel? get partner => _partner;
  set partner(UserModel? val) {
    _partner = val;
    notifyListeners();
  }
}
