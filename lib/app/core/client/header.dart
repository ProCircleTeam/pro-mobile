import 'package:pro_mobile/ui/utils/helper.dart';

Future<Map<String, String>> getAppHeader({
  required bool isTokenRequired,
}) async {
  String? token = isTokenRequired ? await Helper().getAccessToken() : null;

  return {
    if (token != null) 'Authorization': 'Bearer $token',
  };
}
