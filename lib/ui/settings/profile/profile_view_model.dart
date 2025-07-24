import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pro_mobile/ui/base/base_view_model.dart';

class ProfileViewModel extends BaseViewModel {
  final personalInfoFormKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');

  File? _pickedProfileImage;

  File? get pickedProfileImage => _pickedProfileImage;
  set pickedProfileImage(File? val) {
    _pickedProfileImage = val;

    notifyListeners();
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
}
