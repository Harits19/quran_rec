import 'package:flutter/material.dart';
import 'package:quran_rec/context/extension.dart';
import 'package:quran_rec/inherited_widget/state.dart';
import 'package:quran_rec/local/model.dart';
import 'package:quran_rec/local/provider.dart';
import 'package:quran_rec/local/service.dart';
import 'package:quran_rec/quran/model.dart';
import 'package:quran_rec/xml/service.dart';

enum QuranView {
  wrap,
  list;

  const QuranView();

  String toJson() => name;

  static QuranView fromJson(dynamic json) {
    return QuranView.values.firstWhere((item) => item.name == json);
  }
}

class QuranState {
  final QuranModel? quran;
  final QuranView view;

  QuranState({required this.quran, required this.view});
}

class QuranAction {
  final VoidCallback toggleView;

  QuranAction({required this.toggleView});
}

typedef QuranViewModel = StateViewModel<QuranState, QuranAction>;

class QuranProvider extends StatefulWidget {
  const QuranProvider({super.key, required this.builder});

  final StateBuilder<QuranState, QuranAction> builder;

  @override
  State<QuranProvider> createState() => _QuranProviderState();
}

class _QuranProviderState extends State<QuranProvider> {
  QuranModel? quran;
  QuranView view = QuranView.wrap;
  late final pref = context.of<LocalViewModel>().state;
  late final local = LocalService(key: LocalEnumKey.quranView, pref: pref);

  void loadQuranUthmani() async {
    final xmlService = XmlService();
    final document = await xmlService.readXMLFile(XMLFile.quranUthmani);

    final result = QuranModel.fromJson(document);

    quran = result;
    setState(() {});
  }

  void loadQuranView() async {
    view = QuranView.fromJson(local.get());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadQuranUthmani();
    loadQuranView();
  }

  @override
  Widget build(BuildContext context) {
    return MyProvider<QuranState, QuranAction>(
      state: QuranState(quran: quran, view: view),
      action: QuranAction(
        toggleView: () async {
          var nextValue = view.index + 1;
          if (nextValue >= QuranView.values.length) {
            nextValue = 0;
          }
          view = QuranView.values[nextValue];
          setState(() {});
          await local.set(view);
        },
      ),
      builder: widget.builder,
    );
  }
}
