import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class CustomAudioWidget extends StatelessWidget {
  final IconData icon;
  final String audioPath;
  final AudioPlayer audioPlayer;
  final RxBool isPlaying = false.obs;
  final RxDouble volume = 0.5.obs;

  CustomAudioWidget({
    required this.icon,
    required this.audioPath,
    required this.audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: playPauseAudio,
          child: Obx(
            () => AnimatedOpacity(
              opacity: volume.value,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                icon,
                size: 100,
                color: Colors.blue,
              ),
            ),
          ),
        ),
        Obx(
          () => Slider(
            value: volume.value,
            onChanged: setVolume,
            min: 0.0,
            max: 1.0,
          ),
        ),
      ],
    );
  }

  void playPauseAudio() {
    if (isPlaying.value) {
      audioPlayer.pause();
    } else {
      audioPlayer.play(AssetSource(audioPath));
    }
    isPlaying.toggle();
  }

  void setVolume(double newVolume) {
    volume.value = newVolume;
    audioPlayer.setVolume(newVolume);
  }
}
