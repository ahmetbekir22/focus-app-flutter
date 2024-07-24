import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/duration_controller.dart';
import 'custom_number_picker.dart';

class DurationPicker extends StatelessWidget {
  final Duration initialDuration;
  final void Function(Duration) onTimeSelected;

  const DurationPicker({
    Key? key,
    required this.initialDuration,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final durationController = Get.put(DurationController());
    durationController.setInitialDuration(initialDuration);

    return AlertDialog(
      title: const Text(
        'Set Duration',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4A4A4A),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CustomNumberPicker(
                label: 'Hours',
                minValue: 0,
                maxValue: 23,
                currentValue: durationController.hours,
              ),
              CustomNumberPicker(
                label: 'Minutes',
                minValue: 0,
                maxValue: 59,
                currentValue: durationController.minutes,
              ),
              CustomNumberPicker(
                label: 'Seconds',
                minValue: 0,
                maxValue: 59,
                currentValue: durationController.seconds,
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontSize: 18,
              color: Colors.redAccent,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            onTimeSelected(durationController.duration);
            Navigator.of(context).pop();
          },
          child: const Text(
            'Set',
            style: TextStyle(
              fontSize: 18,
              color: Colors.green,
            ),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: const Color(0xFFF9F9F9),
    );
  }
}
