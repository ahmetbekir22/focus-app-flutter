import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/custom_audio_widget.dart';
import '../controller/audio_contoller.dart';
import 'package:audioplayers/audioplayers.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioController = Get.put(AudioController());

    final rainAudioPlayer = AudioPlayer();
    audioController.registerAudioPlayer(rainAudioPlayer);

    final musicAudioPlayer = AudioPlayer();
    audioController.registerAudioPlayer(musicAudioPlayer);

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.blue.shade100,
        title: const Text(
          'Sound Control',
          style: TextStyle(
            color: Color.fromARGB(255, 129, 98, 181),
            fontSize: 27,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomAudioWidget(
              icon: Icons.cloud,
              audioPath: 'sounds/rain_voice.mp3',
              audioPlayer: rainAudioPlayer,
            ),
            CustomAudioWidget(
              icon: Icons.music_note,
              audioPath: 'sounds/cafe_sound.mp3',
              audioPlayer: musicAudioPlayer,
            ),
            // Diğer sesler için CustomAudioWidget ekleyin.
            Obx(
              () => ElevatedButton(
                onPressed: () {
                  if (audioController.isPlaying.value) {
                    audioController.pauseAll();
                  } else {
                    audioController.playAll();
                  }
                },
                child: Text(
                    audioController.isPlaying.value ? 'Pause All' : 'Play All'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
