import 'package:flutter/material.dart';
import 'package:quran_rec/inherited_widget/state.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef LocalViewModel = MyState<SharedPreferences, Null>;

class LocalProvider extends StatefulWidget {
  const LocalProvider({super.key, required this.builder});

  final StateBuilder<SharedPreferences, Null> builder;

  @override
  State<LocalProvider> createState() => _LocalProviderState();
}

class _LocalProviderState extends State<LocalProvider> {
  SharedPreferences? pref;

  @override
  void initState() {
    super.initState();
    initPref();
  }

  void initPref() async {
    pref = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (pref == null) {
      return Center(child: CircularProgressIndicator());
    }
    return MyProvider<SharedPreferences, Null>(
      builder: widget.builder,
      state: pref!,
      action: null,
    );
  }
}
