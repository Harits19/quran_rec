import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  T of<T extends InheritedWidget>() {
    final result = dependOnInheritedWidgetOfExactType<T>();

    if (result == null) {
      throw Exception("Empty State");
    }
    return result;
  }
}
