import 'package:flutter/material.dart';
import 'package:quran_rec/components/my_text_style.dart';

class MyTextSpan extends TextSpan {
  MyTextSpan({
    required BuildContext context,
    super.text,
    super.children,
    MyTextStyle? style,
  }) : super(style: DefaultTextStyle.of(context).style.merge(style));
}
