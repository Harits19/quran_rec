import 'package:flutter/material.dart';
import 'package:quran_rec/inherited_widget/state.dart';
import 'package:quran_rec/quran/model.dart';
import 'package:quran_rec/xml/service.dart';

typedef QuranState = QuranModel;
typedef QuranAction = Null;

typedef QuranViewModel = StateViewModel<QuranState, QuranAction>;

class QuranProvider extends StatefulWidget {
  const QuranProvider({super.key, required this.builder});

  final StateBuilder<QuranState?, QuranAction> builder;

  @override
  State<QuranProvider> createState() => _QuranProviderState();
}

class _QuranProviderState extends State<QuranProvider> {
  QuranState? quranModel;

  void loadQuranUthmani() async {
    final xmlService = XmlService();
    final document = await xmlService.readXMLFile(XMLFile.quranUthmani);

    final result = QuranState.fromJson(document);

    quranModel = result;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadQuranUthmani();
  }

  @override
  Widget build(BuildContext context) {
    return MyProvider<QuranState?, QuranAction>(
      state: quranModel,
      action: null,
      builder: widget.builder,
    );
  }
}
