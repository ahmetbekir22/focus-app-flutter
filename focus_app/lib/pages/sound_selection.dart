import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/audio_controller.dart';

class SoundSelectionDialog extends StatelessWidget {
  final List<Map<String, String>> audioFiles;
  final AudioController audioController;
  final ValueNotifier<List<bool>> selectedSoundsNotifier;

  const SoundSelectionDialog({
    super.key,
    required this.audioFiles,
    required this.audioController,
    required this.selectedSoundsNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final selectedSounds = List<bool>.filled(audioFiles.length, false).obs;

    return AlertDialog(
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
        child: const Text('Select Sounds'),
      ),
      titleTextStyle: const TextStyle(
        color: Color.fromARGB(255, 51, 101, 128),
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: audioFiles.length,
          itemBuilder: (context, index) {
            return Obx(() {
              return CheckboxListTile(
                title: Text(audioFiles[index]['name']!),
                value: selectedSounds[index],
                onChanged: (bool? value) {
                  selectedSounds[index] = value!;
                },
              );
            });
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            for (int i = 0; i < audioFiles.length; i++) {
              if (selectedSounds[i]) {
                audioController.playAudio(audioFiles[i]['audioPath']!);
              } else {
                audioController.pauseAudio(audioFiles[i]['audioPath']!);
              }
            }
            selectedSoundsNotifier.value = selectedSounds.toList();
            Get.back();
          },
          child: const Text('OK',
              style: TextStyle(
                color: Color.fromARGB(255, 105, 131, 145),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              )),
        ),
      ],
    );
  }
}
