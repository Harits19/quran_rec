import 'dart:convert';

import 'package:quran_rec/local/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  final LocalEnumKey key;
  final SharedPreferences pref;

  LocalService({required this.key, required this.pref});

  String get name => key.name;

  Future<void> set(Object? object) async {
    if (object == null) {
      await pref.remove(name);
    }
    await pref.setString(name, json.encode(object));
  }

  Object? get() {
    final result = pref.get(name);
    if (result == null || result is! String) return null;

    return json.decode(result);
  }
}
