import 'package:quran_rec/string/extension.dart';

extension NumberExtension on num {
  String toArabicNumber() {
    return toString().toArabicNumber();
  }
}
