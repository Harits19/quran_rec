import 'package:flutter/material.dart';

class RecordView extends StatelessWidget {
  const RecordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [ElevatedButton(onPressed: () {}, child: Text("Record"))],
        ),
      ),
    );
  }
}
