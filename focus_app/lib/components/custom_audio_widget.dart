import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class CustomAudioWidget extends StatelessWidget {
  final String imagePath;
  final String audioPath;
  final String name;
  final AudioPlayer audioPlayer;
  final RxBool isPlaying = false.obs;
  final RxDouble volume = 0.5.obs;

  CustomAudioWidget({
    super.key,
    required this.imagePath,
    required this.audioPath,
    required this.audioPlayer,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Obx(
            () => AspectRatio(
              aspectRatio: 16 / 9,
              child: AnimatedOpacity(
                opacity: volume.value == 0 ? 0.1 : volume.value,
                duration: const Duration(milliseconds: 150),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Text(
            name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          Obx(
            () => Slider(
              value: volume.value,
              onChanged: setVolume,
              min: 0,
              max: 1.0,
              activeColor: Colors.black54,
              inactiveColor: Colors.black12,
              thumbColor: const Color.fromARGB(255, 107, 107, 107),
            ),
          ),
        ],
      ),
    );
  }

  // void playPauseAudio() async {
  //   if (isPlaying.value) {
  //     await audioPlayer.pause();
  //   } else {
  //     await audioPlayer.setSourceAsset(audioPath);
  //     await audioPlayer.setReleaseMode(ReleaseMode.loop);
  //     await audioPlayer.resume();
  //   }
  //   isPlaying.toggle();
  // }

  void setVolume(double newVolume) {
    volume.value = newVolume;
    audioPlayer.setVolume(newVolume);
  }
}
