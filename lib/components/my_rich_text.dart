import 'package:flutter/material.dart';
import 'package:quran_rec/components/my_text_span.dart';

class MyRichText extends StatelessWidget {
  const MyRichText({super.key, required this.text});

  final MyTextSpan Function(BuildContext) text;

  @override
  Widget build(BuildContext context) {
    return RichText(text: text(context));
  }
}
