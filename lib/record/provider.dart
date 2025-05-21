import 'package:flutter/material.dart';
import 'package:quran_rec/context/extension.dart';
import 'package:quran_rec/inherited_widget/state.dart';
import 'package:quran_rec/quran/model.dart';
import 'package:quran_rec/quran/provider.dart';

class RecordState {
  final bool isRecording;
  final Ayahs? selectedAyah;
  final PageController controller;

  RecordState({
    required this.isRecording,
    required this.controller,
    required this.selectedAyah,
  });
}

class RecordAction {
  final VoidCallback toggleRecording;
  final ValueChanged<bool> changeAyah;

  RecordAction({required this.toggleRecording, required this.changeAyah});
}

typedef RecordViewModel = StateViewModel<RecordState, RecordAction>;

class RecordProvider extends StatefulWidget {
  const RecordProvider({super.key, required this.builder, required this.quran});

  final StateBuilder<RecordState, RecordAction> builder;
  final QuranModel quran;

  @override
  State<RecordProvider> createState() => _RecordProviderState();
}

class _RecordProviderState extends State<RecordProvider> {
  final controller = PageController();

  Ayahs? selectedAyah;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyProvider(
      builder: widget.builder,
      state: RecordState(
        selectedAyah: selectedAyah,
        isRecording: selectedAyah != null,
        controller: controller,
      ),
      action: RecordAction(
        changeAyah: (isNext) {
          final currentPage = controller.page?.toInt() ?? 0;
          final quran = widget.quran;

          if (selectedAyah == null) return;
          final addValue = isNext ? 1 : -1;

          final newAyah =
              (() {
                try {
                  return quran.allAyah.firstWhere(
                    (item) => item.number == (selectedAyah!.number) + addValue,
                  );
                } catch (e) {
                  //ignore
                }
              })();

          if (newAyah == null) return;
          final currentPageAyahs = quran.pages[currentPage];

          final isFound = currentPageAyahs.any(
            (item) => item.number == newAyah.number,
          );
          selectedAyah = newAyah;

          setState(() {});
          if (isFound) return;
          controller.animateToPage(
            currentPage + addValue,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        toggleRecording: () {
          final currentPage = controller.page?.toInt() ?? 0;
          final quran = widget.quran;

          final ayahs = quran.pages[currentPage];
          if (selectedAyah == null) {
            final firstAyah = ayahs.first;

            selectedAyah = firstAyah;

            setState(() {});
          } else {
            selectedAyah = null;
            setState(() {});
          }
        },
      ),
    );
  }
}
