import 'package:flutter/material.dart';
import 'package:quran_rec/inherited_widget/state.dart';
import 'package:quran_rec/quran/model.dart';
import 'package:quran_rec/xml/service.dart';

enum QuranView { wrap, list }

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

  void loadQuranUthmani() async {
    final xmlService = XmlService();
    final document = await xmlService.readXMLFile(XMLFile.quranUthmani);

    final result = QuranModel.fromJson(document);

    quran = result;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadQuranUthmani();
  }

  @override
  Widget build(BuildContext context) {
    return MyProvider<QuranState, QuranAction>(
      state: QuranState(quran: quran, view: view),
      action: QuranAction(
        toggleView: () {
          var nextValue = view.index + 1;
          if (nextValue >= QuranView.values.length) {
            nextValue = 0;
          }
          view = QuranView.values[nextValue];
          setState(() {});
        },
      ),
      builder: widget.builder,
    );
  }
}
