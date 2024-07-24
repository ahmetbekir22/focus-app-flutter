import 'package:flutter/material.dart';

class TimerDialog extends StatelessWidget {
  final Function(Duration) onTimeSelected;

  const TimerDialog({super.key, required this.onTimeSelected});

  @override
  Widget build(BuildContext context) {
    final minutesController = TextEditingController();
    final secondsController = TextEditingController();

    return AlertDialog(
      title: const Text('Set Timer'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: minutesController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Minutes'),
          ),
          TextField(
            controller: secondsController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Seconds'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final minutes = int.tryParse(minutesController.text) ?? 0;
            final seconds = int.tryParse(secondsController.text) ?? 0;
            final duration = Duration(minutes: minutes, seconds: seconds);
            onTimeSelected(duration);
            Navigator.of(context).pop();
          },
          child: const Text('Set'),
        ),
      ],
    );
  }
}
