import 'package:flutter/material.dart';
import 'package:quran_rec/context/extension.dart';
import 'package:quran_rec/quran/provider.dart';
import 'package:quran_rec/record/provider.dart';
import 'package:quran_rec/string/extension.dart';

class FooterView extends StatelessWidget {
  const FooterView({super.key});

  @override
  Widget build(BuildContext context) {
    final record = context.of<RecordViewModel>();
    final quran = context.of<QuranViewModel>();
    final state = record.state;
    final action = record.action;
    final selectedView = quran.state.view;
    return Container(
      width: double.infinity,
      color: Colors.black.withValues(alpha: 0.7),
      padding: EdgeInsets.all(16),
      child: Wrap(
        spacing: 12,
        children: [
          ElevatedButton(
            onPressed: quran.action.toggleView,
            child: Text(selectedView.name.capitalize()),
          ),
          if (!state.isRecording)
            ElevatedButton(
              onPressed: action.toggleRecording,
              child: Text("Record"),
            )
          else ...[
            ElevatedButton(
              onPressed: action.toggleRecording,
              child: Text("Stop Recording"),
            ),

            ElevatedButton(
              onPressed: () => action.changeAyah(false),
              child: Text("Prev"),
            ),
            ElevatedButton(
              onPressed: () => action.changeAyah(true),
              child: Text("Next"),
            ),
          ],
        ],
      ),
    );
  }
}
