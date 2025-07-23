import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/domain/models/user_model.dart';

class SecureStorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> write({required String key, required String val}) async {
    await _secureStorage.write(key: key, value: val);
  }

  Future<String?> read(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }

  Future<void> setUser(UserModel user) async {
    String userString = jsonEncode(user.toJson());
    _secureStorage.write(key: StringConstants.userObject, value: userString);
  }

  Future<UserModel?> getUser() async {
    String? userString = await _secureStorage.read(
      key: StringConstants.userObject,
    );
    if (userString != null) {
      return UserModel.fromJson(jsonDecode(userString));
    }
    return null;
  }
}
