import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/data/remote/user/user_service.dart';
import 'package:pro_mobile/domain/models/time_zone.dart';
import 'package:pro_mobile/ui/base/base_view_model.dart';

class ProfileViewModel extends BaseViewModel {
  final UserService userService;
  ProfileViewModel(this.userService);

  final personalInfoFormKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController yearsOfExperienceController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController careerSummaryController = TextEditingController();
  TextEditingController longTermGoalController = TextEditingController();
  TextEditingController preferredPartnersTraitController =
      TextEditingController();
  TextEditingController availabilityDaysController = TextEditingController();
  TextEditingController funFactController = TextEditingController();

  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');

  String _selectedIndustrySector = industrySectors[0];
  String get selectedIndustrySector => _selectedIndustrySector;
  set selectedIndustrySector(String val) {
    _selectedIndustrySector = val;
    notifyListeners();
  }

  TimeZoneModel _selectedTimeZone = timeZones[0];
  TimeZoneModel get selectedTimeZone => _selectedTimeZone;
  set selectedTimeZone(TimeZoneModel val) {
    _selectedTimeZone = val;
    notifyListeners();
  }

  String _selectedInterest = interests[0];
  String get selectedInterest => _selectedInterest;
  set selectedInterest(String val) {
    _selectedInterest = val;
    notifyListeners();
  }

  File? _pickedProfileImage;

  File? get pickedProfileImage => _pickedProfileImage;
  set pickedProfileImage(File? val) {
    _pickedProfileImage = val;

    notifyListeners();
  }

  bool _isPersonalInfoCompleted = false;
  bool get isPersonalInfoCompleted => _isPersonalInfoCompleted;
  set isPersonalInfoCompleted(bool val) {
    _isPersonalInfoCompleted = val;
    notifyListeners();
  }

  bool _isProfessionalInfoCompleted = false;
  bool get isProfessionalInfoCompleted => _isProfessionalInfoCompleted;
  set isProfessionalInfoCompleted(bool val) {
    _isProfessionalInfoCompleted = val;
    notifyListeners();
  }

  bool _isGoalInfoCompleted = false;
  bool get isGoalInfoCompleted => _isGoalInfoCompleted;
  set isGoalInfoCompleted(bool val) {
    _isGoalInfoCompleted = val;
    notifyListeners();
  }

  bool _isEngagementInfoCompleted = false;
  bool get isEngagementInfoCompleted => _isEngagementInfoCompleted;
  set isEngagementInfoCompleted(bool val) {
    _isEngagementInfoCompleted = val;
    notifyListeners();
  }

  bool _isFetchingProfileStatus = false;
  bool get isFetchingProfileStatus => _isFetchingProfileStatus;
  set isFetchingProfileStatus(bool val) {
    _isFetchingProfileStatus = val;
    notifyListeners();
  }

  bool _isUpdatingProfessionalInfo = false;
  bool get isUpdatingProfessionalInfo => _isUpdatingProfessionalInfo;
  set isUpdatingProfessionalInfo(bool val) {
    _isUpdatingProfessionalInfo = val;
    notifyListeners();
  }

  bool _isUpdatingLongTermGoal = false;
  bool get isUpdatingLongTermGoal => _isUpdatingLongTermGoal;
  set isUpdatingLongTermGoal(bool val) {
    _isUpdatingLongTermGoal = val;
    notifyListeners();
  }

  bool isProfessionalInfoFormValid({
    required String jobTitle,
    required String yearsOfExperience,
    required String careerSummary,
    required String industrySector,
    required Function(String e) onError,
  }) {
    if (jobTitle.length < 3) {
      String error = "jobTitle length must be greater than 2";
      onError(error);
      return false;
    } else if (int.tryParse(yearsOfExperience) == null) {
      String error = "Invalid years of experience";
      onError(error);
      return false;
    } else if (industrySector.length < 3) {
      String error = "Industry sector length must be greater than 2";
      onError(error);
      return false;
    } else if (industrySector == industrySectors[0]) {
      String error = "Kindly select an Industry sector to proceed";
      onError(error);
      return false;
    } else if (careerSummary.length < 8) {
      String error = "Career summary length must be greater than 7";
      onError(error);
      return false;
    } else {
      return true;
    }
  }

  bool isPersonalInfoFormValid({
    required String username,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String bio,
    required File? image,
    required Function(String e) onError,
  }) {
    if (username.length < 3) {
      String error = "Username length must be greater than 2";
      onError(error);
      return false;
    } else if (firstName.length < 3) {
      String error = "First Name length must be greater than 2";
      onError(error);
      return false;
    } else if (lastName.length < 3) {
      String error = "Last Name length must be greater than 2";
      onError(error);
      return false;
    } else if (phoneNumber.length < 8) {
      String error = "Phone number length must be greater than 7";
      onError(error);
      return false;
    } else if (bio.length < 21) {
      String error = "Bio length must be greater than 20";
      onError(error);
      return false;
    }
    if (image == null) {
      String error = "Kindly select profile image to proceed";
      onError(error);
      return false;
    } else {
      return true;
    }
  }

  bool isGoalAndInterestFormValid({
    required String interest,
    required String partnerTrait,
    required String longTermGoal,
    required Function(String e) onError,
  }) {
    if (partnerTrait.length < 3) {
      String error = "Kindly enter the traits fo partner you will like to have";
      onError(error);
      return false;
    } else if (interest.length < 3 || interest == interests[0]) {
      String error = "Pick an interest to continue";
      onError(error);
      return false;
    } else if (longTermGoal.length < 8) {
      String error = "Long term goal length must be greater than 7";
      onError(error);
      return false;
    } else {
      return true;
    }
  }

  bool isEngagementFormValid({
    required String availableDays,
    required int timeZone,
    required String funFact,
    required Function(String e) onError,
  }) {
    if (availableDays.length < 3) {
      String error = "Kindly enter the days in the week you are available";
      onError(error);
      return false;
    } else if (timeZone == timeZones.first.id) {
      String error = "Pick a time zone to continue";
      onError(error);
      return false;
    } else if (funFact.length < 3) {
      String error = "Kindly enter a valid fun fact";
      onError(error);
      return false;
    } else {
      return true;
    }
  }

  Future<void> getUserProfileCompletionStatus(
    Function(String e) onError,
  ) async {
    try {
      isFetchingProfileStatus = true;

      var res = await userService.getUserProfileStatus();
      isPersonalInfoCompleted = res["personalInfoComplete"];
      isProfessionalInfoCompleted = res["professionalInfoComplete"];
      isGoalInfoCompleted = res["goalsInfoComplete"];
      isEngagementInfoCompleted = res["engagementInfoComplete"];

      isFetchingProfileStatus = false;
    } catch (e) {
      onError(ErrorText.generic);
    }
  }

  Future<void> updateProfessionalInfo({
    required String careerSummary,
    required int industrySectorId,
    required String jobTitle,
    required int yearsOfExperience,
    required Function(String e) onSuccess,
    required Function(String e) onError,
  }) async {
    try {
      isUpdatingProfessionalInfo = true;

      var res = await userService.updateUserProfessionalInfo(
        jobTitle: jobTitle,
        careerSummary: careerSummary,
        industrySectorId: industrySectorId,
        yearsOfExperience: yearsOfExperience,
      );
      onSuccess("Professional info added successfully");

      print("This is the response ======================> $res");

      isUpdatingProfessionalInfo = false;
    } catch (e) {
      onError(ErrorText.generic);
      isUpdatingProfessionalInfo = false;
    }
  }

  Future<void> updateLongTermGoal({
   required List<int> addAreaOfInterests,
    required List<int> removeAreaOfInterests,
    required String longTermGoal,
    required String preferredAccountabilityPartnerTrait,
    required Function(String e) onSuccess,
    required Function(String e) onError,
  }) async {
    try {
      isUpdatingLongTermGoal = true;

      var res = await userService.updateLongTermGoal(
        addAreaOfInterests: addAreaOfInterests,
        removeAreaOfInterests: removeAreaOfInterests,
        longTermGoal: longTermGoal,
        preferredAccountabilityPartnerTrait: preferredAccountabilityPartnerTrait,
      );
      onSuccess("Goals and Interest updated successfully");

      print("This is the response ======================> $res");

      isUpdatingLongTermGoal = false;
    } catch (e) {
      onError(ErrorText.generic);
      isUpdatingLongTermGoal = false;
    }
  }
}
