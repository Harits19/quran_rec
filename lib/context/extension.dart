import 'package:flutter/material.dart';
import 'package:quran_rec/inherited_widget/state.dart';

extension ContextExtension on BuildContext {
  T of<T extends MyState>() {
    final result = dependOnInheritedWidgetOfExactType<T>();

    if (result == null) {
      throw Exception("Empty State");
    }
    return result;
  }


}
