import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pro_mobile/app/core/client/app_client.dart';
import 'package:pro_mobile/app/core/client/header.dart';
import 'package:pro_mobile/app/core/endpoints/endpoints.dart';
import 'package:pro_mobile/data/remote/user/user_service.dart';
import 'package:pro_mobile/domain/models/user_model.dart';

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
  Future<UserModel?> getUserById(int id) async {
    String url = Endpoints.getUserById(id);

    final header = await getAppHeader(isTokenRequired: true);
    Response? res = await appClient.get(url, headers: header);
    var resData = res?.data["data"];
    return UserModel.fromJson(resData);
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
      "preferredAccountabilityPartnerTrait":
          preferredAccountabilityPartnerTrait,
    };

    final header = await getAppHeader(isTokenRequired: true);
    Response? res = await appClient.put(url, data, headers: header);
    return res?.data["data"];
  }

  @override
  Future<void> updateEngagementInfo({
    required List<String> availabilityDays,
    required String funFact,
    required int timeZone,
  }) async {
    String url = Endpoints.updateEngagementInfo;
    Map<String, dynamic> data = {
      "availabilityDays": availabilityDays,
      "timeZone": timeZone,
      "funFact": funFact,
    };

    final header = await getAppHeader(isTokenRequired: true);
    Response? res = await appClient.put(url, data, headers: header);
    return res?.data["data"];
  }

  @override
  Future<void> updatePersonalInfo({
    required String username,
    required String firstName,
    required String lastName,
    required String phone,
    required String bio,
    required File? profilePhoto,
  }) async {
    String url = Endpoints.updatePersonalInfo;
    Dio dio = Dio();

    final formData = FormData.fromMap({
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'bio': bio,
      if(profilePhoto != null)
      'profilePhoto': await MultipartFile.fromFile(
        profilePhoto.path,
        filename: profilePhoto.path.split('/').last,
      ),
    });

    final header = await getAppHeader(isTokenRequired: true);
    header['Content-Type'] = 'multipart/form-data';
    Response? res = await dio.put(
      url,
      data: formData,
      options: Options(headers: header),
    );
    return res.data["data"];
  }
}
