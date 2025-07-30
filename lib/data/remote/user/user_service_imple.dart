import 'package:dio/dio.dart';
import 'package:pro_mobile/app/core/client/app_client.dart';
import 'package:pro_mobile/app/core/client/header.dart';
import 'package:pro_mobile/app/core/endpoints/endpoints.dart';
import 'package:pro_mobile/data/remote/user/user_service.dart';

class UserServiceImpl implements UserService {
  final AppClient appClient;
  UserServiceImpl(this.appClient);

  @override
  Future<Map<String, dynamic>> getUserProfileStatus() async {
    String url = Endpoints.getUserProfileStatus;

    final header = await getAppHeader(isTokenRequired: true);
    Response? res = await appClient.get(url, headers: header);
    return res?.data["data"];
  }

  @override
  Future<List> getSupportedTimeZones() async {
    String url = Endpoints.getSupportedTimeZones;

    final header = await getAppHeader(isTokenRequired: true);
    Response? res = await appClient.get(url, headers: header);
    return res?.data["data"];
  }

  @override
  Future<Map<String, dynamic>> updateUserProfessionalInfo({
    required String careerSummary,
    required int industrySectorId,
    required String jobTitle,
    required int yearsOfExperience,
  }) async {
    String url = Endpoints.updateProfessionalInfo;
    Map<String, dynamic> data = {
      "careerSummary": careerSummary,
      "industrySectorId": industrySectorId,
      "jobTitle": jobTitle,
      "yearsOfExperience": yearsOfExperience,
    };

    final header = await getAppHeader(isTokenRequired: true);
    Response? res = await appClient.put(url, data, headers: header);
    return res?.data["data"];
  }

  @override
  Future<Map<String, dynamic>> updateLongTermGoal({
    required List<int> addAreaOfInterests,
    required List<int> removeAreaOfInterests,
    required String longTermGoal,
    required String preferredAccountabilityPartnerTrait,
  }) async {
    String url = Endpoints.updateLongTermGoal;
    Map<String, dynamic> data = {
      "addAreaOfInterests": addAreaOfInterests,
      "removeAreaOfInterests": removeAreaOfInterests,
      "longTermGoal": longTermGoal,
      "preferredAccountabilityPartnerTrait": preferredAccountabilityPartnerTrait,
    };

    final header = await getAppHeader(isTokenRequired: true);
    Response? res = await appClient.put(url, data, headers: header);
    return res?.data["data"];
  }
}
