import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pro_mobile/ui/widgets/app_text_style.dart';

void main() {
  group('AppTextStyle', () {
    test('title() returns default TextStyle', () {
      final style = AppTextStyle.title();
      expect(style.fontSize, 28);
      expect(style.fontWeight, FontWeight.bold);
      expect(style.color, isNull);
    });

    test('subTitle() returns default TextStyle', () {
      final style = AppTextStyle.subTitle();
      expect(style.fontSize, 16);
      expect(style.fontWeight, FontWeight.bold);
      expect(style.color, isNull);
    });

    test('medium() returns default TextStyle', () {
      final style = AppTextStyle.medium();
      expect(style.fontSize, 14);
      expect(style.fontWeight, FontWeight.bold);
      expect(style.color, isNull);
    });

    test('caption() returns default TextStyle', () {
      final style = AppTextStyle.caption();
      expect(style.fontSize, 12);
      expect(style.fontWeight, FontWeight.bold);
      expect(style.color, isNull);
    });

    test('title() returns customized TextStyle', () {
      final style = AppTextStyle.title(
        fontSize: 30,
        fontWeight: FontWeight.w300,
        color: Colors.red,
      );
      expect(style.fontSize, 30);
      expect(style.fontWeight, FontWeight.w300);
      expect(style.color, Colors.red);
    });

    test('subTitle() returns customized TextStyle', () {
      final style = AppTextStyle.subTitle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.green,
      );
      expect(style.fontSize, 18);
      expect(style.fontWeight, FontWeight.w500);
      expect(style.color, Colors.green);
    });

    test('medium() returns customized TextStyle', () {
      final style = AppTextStyle.medium(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.blue,
      );
      expect(style.fontSize, 16);
      expect(style.fontWeight, FontWeight.w400);
      expect(style.color, Colors.blue);
    });

    test('caption() returns customized TextStyle', () {
      final style = AppTextStyle.caption(
        fontSize: 10,
        fontWeight: FontWeight.w100,
        color: Colors.black,
      );
      expect(style.fontSize, 10);
      expect(style.fontWeight, FontWeight.w100);
      expect(style.color, Colors.black);
    });
  });
}
