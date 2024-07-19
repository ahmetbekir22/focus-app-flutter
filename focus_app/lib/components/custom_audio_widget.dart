import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class CustomAudioWidget extends StatelessWidget {
  final String imagePath;
  final String audioPath;
  final AudioPlayer audioPlayer;
  final RxBool isPlaying = false.obs;
  final RxDouble volume = 0.5.obs;

  CustomAudioWidget({
    required this.imagePath,
    required this.audioPath,
    required this.audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: playPauseAudio,
          child: Obx(
            () => AnimatedOpacity(
              opacity: volume.value,
              duration: const Duration(milliseconds: 300),
              child: SizedBox(
                width: width * 0.5,
                height: height * 0.15,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Obx(
          () => Slider(
            value: volume.value,
            onChanged: setVolume,
            min: 0.08,
            max: 1.0,
            activeColor: Colors.black54,
            inactiveColor: Colors.black12,
            thumbColor: const Color.fromARGB(255, 107, 107, 107),
          ),
        ),
      ],
    );
  }

  void playPauseAudio() async {
    if (isPlaying.value) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.setSourceAsset(audioPath);
      await audioPlayer.setReleaseMode(ReleaseMode.loop);
      await audioPlayer.resume();
    }
    isPlaying.toggle();
  }

  void setVolume(double newVolume) {
    volume.value = newVolume;
    audioPlayer.setVolume(newVolume);
  }
}
