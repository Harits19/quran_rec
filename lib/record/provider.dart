import 'package:flutter/material.dart';
import 'package:quran_rec/inherited_widget/state.dart';

class RecordState {
  bool isRecording;

  RecordState({required this.isRecording});
}

class RecordAction {
  final VoidCallback toggleRecording;

  RecordAction({required this.toggleRecording});
}

typedef RecordViewModel = StateViewModel<RecordState, RecordAction>;

class RecordProvider extends StatefulWidget {
  const RecordProvider({super.key, required this.builder});

  final StateBuilder<RecordState, RecordAction> builder;

  @override
  State<RecordProvider> createState() => _RecordProviderState();
}

class _RecordProviderState extends State<RecordProvider> {
  RecordState state = RecordState(isRecording: false);

  @override
  Widget build(BuildContext context) {
    return MyProvider(
      builder: widget.builder,
      state: state,
      action: RecordAction(
        toggleRecording: () {
          state.isRecording = !state.isRecording;
          setState(() {});
        },
      ),
    );
  }
}
