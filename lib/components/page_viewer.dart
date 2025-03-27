import 'package:flutter/material.dart';
import 'package:quran_rec/components/my_rich_text.dart';
import 'package:quran_rec/components/my_text_span.dart';
import 'package:quran_rec/components/my_text_style.dart';
import 'package:quran_rec/models/quran_model.dart';

class PageViewer extends StatelessWidget {
  const PageViewer({super.key, required this.sura});

  final SuraModel sura;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: MyTextStyle(context: context, fontFamily: FontFamily.amiri),
      child: ListView(
        padding: EdgeInsets.all(24),
        children: [
          Row(children: [Text(sura.name)]),
          MyRichText(
            text:
                (context) => MyTextSpan(
                  context: context,
                  children:
                      sura.ayas.map((e) {
                        return TextSpan(text: "${e.text} (${e.index}) ");
                      }).toList(),
                ),
          ),
        ],
      ),
    );
  }
}
