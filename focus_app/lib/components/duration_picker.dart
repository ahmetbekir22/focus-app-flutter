import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:get/get.dart';
import '../controller/duration_controller.dart';

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
      title: const Text('Set Duration'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text('Hours'),
                    Obx(() => NumberPicker(
                          value: durationController.hours.value,
                          minValue: 0,
                          maxValue: 23,
                          onChanged: (value) =>
                              durationController.hours.value = value,
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text('Minutes'),
                    Obx(() => NumberPicker(
                          value: durationController.minutes.value,
                          minValue: 0,
                          maxValue: 59,
                          onChanged: (value) =>
                              durationController.minutes.value = value,
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text('Seconds'),
                    Obx(() => NumberPicker(
                          value: durationController.seconds.value,
                          minValue: 0,
                          maxValue: 59,
                          onChanged: (value) =>
                              durationController.seconds.value = value,
                        )),
                  ],
                ),
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
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onTimeSelected(durationController.duration);
            Navigator.of(context).pop();
          },
          child: const Text('Set'),
        ),
      ],
    );
  }
}
