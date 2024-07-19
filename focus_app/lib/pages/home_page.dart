import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/custom_audio_widget.dart';
import '../controller/audio_contoller.dart';
import 'package:audioplayers/audioplayers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final audioController = Get.put(AudioController());

    final rainAudioPlayer = AudioPlayer();
    audioController.registerAudioPlayer(rainAudioPlayer);
    rainAudioPlayer.setSourceAsset('sounds/rain_voice.mp3');
    final musicAudioPlayer = AudioPlayer();
    audioController.registerAudioPlayer(musicAudioPlayer);
    musicAudioPlayer.setSourceAsset('sounds/cafe_sound.mp3');

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: const Color.fromARGB(255, 79, 79, 80),
        title: const Text(
          'Rest Time ',
          style: TextStyle(
            color: Color.fromARGB(255, 233, 231, 236),
            fontSize: 23,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 142, 142, 144),
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
                children: [
                  CustomAudioWidget(
                    icon: Icons.cloud,
                    audioPath: 'sounds/rain_voice.mp3',
                    audioPlayer: rainAudioPlayer,
                  ),
                  CustomAudioWidget(
                    icon: Icons.coffee,
                    audioPath: 'sounds/cafe_sound.mp3',
                    audioPlayer: musicAudioPlayer,
                  ),
                  CustomAudioWidget(
                    icon: Icons.coffee,
                    audioPath: 'sounds/cafe_sound.mp3',
                    audioPlayer: musicAudioPlayer,
                  ),
                  CustomAudioWidget(
                    icon: Icons.coffee,
                    audioPath: 'sounds/cafe_sound.mp3',
                    audioPlayer: musicAudioPlayer,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
