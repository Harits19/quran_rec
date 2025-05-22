import 'package:flutter/material.dart';
import 'package:quran_rec/audio_player/service.dart';
import 'package:quran_rec/file/service.dart';
import 'package:quran_rec/inherited_widget/state.dart';
import 'package:quran_rec/quran/model.dart';
import 'package:quran_rec/record/service.dart';

class RecordState {
  final bool isRecording, isPlaying;
  final Ayahs? selectedAyah;
  final PageController controller;

  RecordState({
    required this.isRecording,
    required this.controller,
    required this.selectedAyah,
    required this.isPlaying,
  });
}

class RecordAction {
  final VoidCallback toggleRecording, play, stop;
  final ValueChanged<bool> changeAyah;
  final ValueChanged<Ayahs?> onSelectAyah;

  RecordAction({
    required this.toggleRecording,
    required this.changeAyah,
    required this.onSelectAyah,
    required this.play,
    required this.stop,
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

  bool isRecording = false, isPlaying = false;

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

  Future<bool> changeAyah(bool isNext) async {
    final currentPage = controller.page?.toInt() ?? 0;

    if (selectedAyah == null) return false;
    final addValue = isNext ? 1 : -1;

    final newAyah = quran.nextAyah(selectedAyah, addValue);

    if (newAyah == null) return false;
    final currentPageAyahs = quran.pages[currentPage];

    final isFound = currentPageAyahs.any(
      (item) => item.number == newAyah.number,
    );

    if (!isFound) {
      await controller.animateToPage(
        currentPage + addValue,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }

    selectedAyah = newAyah;

    setState(() {});

    return true;
  }

  var audio = AudioPlayerService();

  void playAudio() async {
    isPlaying = true;
    setState(() {});
    final file = FileService.tryCreate(selectedAyah);
    final isExist = await file.exist();
    if (!isExist) {
      isPlaying = false;
      setState(() {});
      return;
    }

    await audio.play(ayah: selectedAyah);

    final isChanged = await changeAyah(true);
    if (!isChanged) {
      isPlaying = false;
      setState(() {});
      return;
    }
    playAudio();
  }

  void stopAudio() async {
    await audio.stop();
    isPlaying = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MyProvider(
      builder: widget.builder,
      state: RecordState(
        isPlaying: isPlaying,
        selectedAyah: selectedAyah,
        isRecording: isRecording,
        controller: controller,
      ),
      action: RecordAction(
        stop: stopAudio,
        play: playAudio,
        onSelectAyah: (ayah) {
          selectedAyah = ayah;
          setState(() {});
        },
        changeAyah: (isNext) async {
          await stopRecord();
          changeAyah(isNext);
          await startRecord();
        },
        toggleRecording: () async {
          if (!isRecording) {
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
