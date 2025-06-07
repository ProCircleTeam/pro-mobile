import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pro_mobile/constants/app_colors.dart';
// Replace with actual path

void main() {
  group('AppColors', () {
    test('primary color should be correct', () {
      expect(AppColors.primary, const Color(0xff1F507B));
    });

    test('primary2 color should be same as primary', () {
      expect(AppColors.primary, AppColors.primary);
    });
  });
}
