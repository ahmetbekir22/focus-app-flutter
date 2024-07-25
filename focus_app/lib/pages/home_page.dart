import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/control_panel.dart';
import '../components/custom_audio_widget.dart';
import 'package:audioplayers/audioplayers.dart';
import '../controller/audio_controller.dart';
import '../data/audios.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final audioList = Audios();
    final List<AudioPlayer> audioPlayers =
        audioList.audioFiles.map((audioFile) {
      final player = AudioPlayer();
      player.setSourceAsset(audioFile['audioPath']!);
      player.setReleaseMode(ReleaseMode.loop);
      return player;
    }).toList();

    final selectedSoundsNotifier = ValueNotifier<List<bool>>(
      List.filled(audioList.audioFiles.length, true),
    );

    final audioController = Get.put(AudioController(
      audioPaths: audioList.audioFiles.map((e) => e['audioPath']!).toList(),
      selectedSounds: List.filled(audioList.audioFiles.length, true),
    ));

    for (int i = 0; i < audioPlayers.length; i++) {
      audioController.registerAudioPlayer(
          audioPlayers[i], audioList.audioFiles[i]['audioPath']!);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 105, 131, 145),
        title: const Text(
          'Rest Time',
          style: TextStyle(
            color: Color.fromARGB(255, 233, 231, 236),
            fontSize: 23,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ControlPanel(
                audioList: audioList,
                selectedSoundsNotifier: selectedSoundsNotifier,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.01, horizontal: Get.width * 0.01),
              child: ValueListenableBuilder<List<bool>>(
                valueListenable: selectedSoundsNotifier,
                builder: (context, selectedSounds, child) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: Get.height * 0.02,
                      crossAxisSpacing: Get.width * 0.02,
                    ),
                    itemCount: audioList.audioFiles.length,
                    itemBuilder: (context, index) {
                      return Opacity(
                        opacity: selectedSounds[index] ? 1.0 : 0.5,
                        child: CustomAudioWidget(
                          imagePath: audioList.audioFiles[index]['imagePath']!,
                          name: audioList.audioFiles[index]['name']!,
                          audioPath: audioList.audioFiles[index]['audioPath']!,
                          audioPlayer: audioPlayers[index],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
