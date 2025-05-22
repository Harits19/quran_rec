import 'package:flutter/material.dart';
import 'package:quran_rec/file/service.dart';
import 'package:quran_rec/inherited_widget/state.dart';
import 'package:quran_rec/quran/model.dart';
import 'package:quran_rec/record/service.dart';

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
  final ValueChanged<Ayahs> play;

  RecordAction({
    required this.toggleRecording,
    required this.changeAyah,
    required this.play,
  });
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
  final service = RecordService.create();
  late final quran = widget.quran;

  bool isRecording = false;

  Ayahs? selectedAyah;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  startRecord() async {
    setState(() {
      isRecording = true;
    });
    await service.start(ayah: selectedAyah);
  }

  stopRecord() async {
    setState(() {
      isRecording = false;
    });
    await service.stop();
  }

  Future<void> changeAyah(bool isNext) async {
    final currentPage = controller.page?.toInt() ?? 0;

    if (selectedAyah == null) return;
    final addValue = isNext ? 1 : -1;

    final newAyah = quran.nextAyah(selectedAyah, addValue);

    if (newAyah == null) return;
    final currentPageAyahs = quran.pages[currentPage];

    final isFound = currentPageAyahs.any(
      (item) => item.number == newAyah.number,
    );
    selectedAyah = newAyah;

    setState(() {});
    if (!isFound) {
      controller.animateToPage(
        currentPage + addValue,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  void play() async {
    final file = FileService.tryCreate(selectedAyah);
    final isExist = await file.exist();
    if (!isExist) {
      return;
    }

    await service.play(ayah: selectedAyah);

    final nextAyah = quran.nextAyah(selectedAyah, 1);
    selectedAyah = nextAyah;
    setState(() {});
    if (nextAyah == null) return;
    play();
  }

  @override
  Widget build(BuildContext context) {
    return MyProvider(
      builder: widget.builder,
      state: RecordState(
        selectedAyah: selectedAyah,
        isRecording: isRecording,
        controller: controller,
      ),
      action: RecordAction(
        play: (ayah) {
          play(ayah);
        },
        changeAyah: (isNext) async {
          await stopRecord();
          changeAyah(isNext);
          await startRecord();
        },
        toggleRecording: () async {
          final currentPage = controller.page?.toInt() ?? 0;
          final quran = widget.quran;

          final ayahs = quran.pages[currentPage];
          if (selectedAyah == null) {
            final firstAyah = ayahs.first;

            selectedAyah = firstAyah;

            setState(() {});
            await startRecord();
          } else {
            selectedAyah = null;
            setState(() {});
            await stopRecord();
          }
        },
      ),
    );
  }
}
