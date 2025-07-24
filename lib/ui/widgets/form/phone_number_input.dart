import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pro_mobile/constants/app_colors.dart';

class PhoneNumberInput extends StatelessWidget {
  final TextEditingController? controller;
  final PhoneNumber number;
  final Function(String)? onChanged;

  const PhoneNumberInput({
    required this.number,
    this.controller,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    PhoneNumber number = PhoneNumber(isoCode: 'NG');

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * .03, vertical: size.height * .002),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.softGrey),
        borderRadius: BorderRadius.circular(6),
      ),
      child: InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber number) {
          // print(number.phoneNumber);
        },
        onInputValidated: (bool value) {
          // print(value);
        },
        selectorConfig: SelectorConfig(
          selectorType: PhoneInputSelectorType.DIALOG,
          useBottomSheetSafeArea: true,
        ),
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle: TextStyle(color: Colors.black),
        initialValue: number,
        textFieldController: controller,
        formatInput: true,
        keyboardType: TextInputType.numberWithOptions(
          signed: true,
          decimal: true,
        ),
        inputBorder: InputBorder.none,
        onSaved: (PhoneNumber number) {
          // print('On Saved: $number');
        },
      ),
    );
  }
}
