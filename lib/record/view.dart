import 'package:flutter/material.dart';
import 'package:quran_rec/context/extension.dart';
import 'package:quran_rec/record/provider.dart';

class RecordView extends StatelessWidget {
  const RecordView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.of<RecordViewModel>();
    final state = viewModel.state;
    final action = viewModel.action;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        color: Colors.black.withValues(alpha: 0.7),
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            if (!state.isRecording)
              ElevatedButton(
                onPressed: action?.toggleRecording,
                child: Text("Record"),
              )
            else
              ElevatedButton(
                onPressed: action?.toggleRecording,
                child: Text("Stop Recording"),
              ),
          ],
        ),
      ),
    );
  }
}
