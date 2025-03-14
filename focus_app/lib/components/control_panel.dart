import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/duration_picker.dart';
import '../controller/audio_controller.dart';
import '../data/audios.dart';
import '../pages/sound_selection.dart';

class ControlPanel extends StatelessWidget {
  final Audios audioList;
  final ValueNotifier<List<bool>> selectedSoundsNotifier;

  ControlPanel({
    super.key,
    required this.audioList,
    required this.selectedSoundsNotifier,
  });

  final AudioController audioController = Get.find<AudioController>();

  bool isCustomMixActive(List<bool> selectedSounds) {
    return selectedSounds.any((isSelected) => !isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DurationPicker(
                        initialDuration: Duration.zero,
                        onTimeSelected: (duration) {
                          audioController.startTimer(duration);
                        },
                      );
                    },
                  );
                },
                icon: const Icon(Icons.timer),
                iconSize: 40,
                color: const Color.fromARGB(255, 85, 73, 73),
              ),
              Obx(
                () => Text(
                  '${audioController.remainingTime.value.inMinutes}:${(audioController.remainingTime.value.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 90, 82, 82),
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: audioController.remainingTime.value > Duration.zero,
                  child: IconButton(
                    onPressed: () {
                      audioController.stopTimer();
                    },
                    icon: const Icon(Icons.stop_circle_outlined),
                    iconSize: 40,
                    color: const Color.fromARGB(255, 203, 70, 70),
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () => IconButton(
              onPressed: () {
                if (audioController.isPlaying.value) {
                  audioController.pauseAll();
                } else {
                  audioController.playSelected(selectedSoundsNotifier.value);
                }
              },
              icon: Icon(
                audioController.isPlaying.value
                    ? Icons.pause
                    : Icons.play_arrow,
                size: 50,
                color: Colors.white,
              ),
              style: ButtonStyle(
                shape: WidgetStateProperty.all(const CircleBorder()),
                backgroundColor: WidgetStateProperty.all(
                    const Color.fromARGB(255, 71, 65, 65)),
              ),
            ),
          ),
          Column(children: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SoundSelectionDialog(
                      audioFiles: audioList.audioFiles,
                      audioController: audioController,
                      selectedSoundsNotifier: selectedSoundsNotifier,
                    );
                  },
                );
              },
              icon: const Icon(Icons.queue_music_outlined),
              iconSize: 40,
              color: const Color.fromARGB(255, 85, 71, 71),
            ),
            ValueListenableBuilder<List<bool>>(
              valueListenable: selectedSoundsNotifier,
              builder: (context, selectedSounds, child) {
                return Visibility(
                  visible: isCustomMixActive(selectedSounds),
                  child: IconButton(
                    onPressed: () {
                      audioController.pauseAll();
                      selectedSoundsNotifier.value =
                          List.filled(audioList.audioFiles.length, true);
                    },
                    icon: const Icon(Icons.stop_circle_outlined),
                    iconSize: 40,
                    color: const Color.fromARGB(255, 203, 70, 70),
                  ),
                );
              },
            ),
          ])
        ],
      ),
    );
  }
}
