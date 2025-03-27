import 'package:flutter/material.dart';

enum FontFamily {
  amiri("Amiri");

  const FontFamily(this.name);

  final String name;
}

class MyTextStyle extends TextStyle {
  MyTextStyle({
    required BuildContext context,
    Color? color,
    FontFamily? fontFamily,
    super.fontSize,
  }) : super(
         fontFamily: fontFamily?.name,
         color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
       );
}
