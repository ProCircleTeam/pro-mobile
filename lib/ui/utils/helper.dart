import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/data/local/secure_storage.dart';

class Helper {
  Future<String?> getAccessToken() async {
    SecureStorageService storage = SecureStorageService();
    return await storage.read(StringConstants.authToken);
  }
}
