import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/custom_audio_widget.dart';
import 'package:audioplayers/audioplayers.dart';

import '../controller/audio_contoller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final audioController = Get.put(AudioController());

    final List<Map<String, String>> audioFiles = [
      {
        'imagePath': 'assets/images/rain.png',
        'audioPath': 'sounds/rain_voice.mp3'
      },
      {
        'imagePath': 'assets/images/cafe.jpeg',
        'audioPath': 'sounds/cafe_sound.mp3'
      },
      {
        'imagePath': 'assets/images/fire-icon.jpg',
        'audioPath': 'sounds/fire_sound.mp3'
      },
      {
        'imagePath': 'assets/images/birds-icon.jpg',
        'audioPath': 'sounds/birds_sound.mp3'
      },
      {
        'imagePath': 'assets/images/waves.png',
        'audioPath': 'sounds/waves_sound.mp3'
      },
    ];

    final List<AudioPlayer> audioPlayers = audioFiles.map((audioFile) {
      final player = AudioPlayer();
      player.setSourceAsset(audioFile['audioPath']!);
      audioController.registerAudioPlayer(player);
      return player;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: const Color.fromARGB(255, 79, 79, 80),
        title: const Text(
          'Rest Time',
          style: TextStyle(
            color: Color.fromARGB(255, 233, 231, 236),
            fontSize: 23,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Center(
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      if (audioController.isPlaying.value) {
                        audioController.pauseAll();
                      } else {
                        audioController.playAll();
                      }
                    },
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(const CircleBorder()),
                      backgroundColor: WidgetStateProperty.all(
                          const Color.fromARGB(255, 71, 65, 65)),
                    ),
                    icon: Icon(
                      size: 40,
                      audioController.isPlaying.value
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                padding: EdgeInsets.zero,
                children: List.generate(audioFiles.length, (index) {
                  return CustomAudioWidget(
                    imagePath: audioFiles[index]['imagePath']!,
                    audioPath: audioFiles[index]['audioPath']!,
                    audioPlayer: audioPlayers[index],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
