import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? title;
  final double? size, space;
  final Color? color;
  final FontWeight? weight;
  final String? fontFamily;
  final double? height;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextDecoration? underline;
  const CustomText(
    this.title, {
    super.key,
    this.size,
    this.space,
    this.color,
    this.weight,
    this.height,
    this.textAlign,
    this.overflow,
    this.fontFamily,
    this.underline,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      textAlign: textAlign ?? TextAlign.left,
      style: TextStyle(
        color: color ?? Colors.black,
        fontFamily: 'SourceSan3',
        fontSize: size,
        height: height ?? 1.4,
        fontWeight: weight ?? FontWeight.normal,
        overflow: overflow,
        decoration: underline ?? TextDecoration.none,
        letterSpacing: space ?? 0,
      ),
    );
  }
}
