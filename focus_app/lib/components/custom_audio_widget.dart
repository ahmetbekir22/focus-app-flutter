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
      mainAxisSize:
          MainAxisSize.min, // Taşmaları önlemek için mainAxisSize kullanın
      children: [
        GestureDetector(
          onTap: playPauseAudio,
          child: Obx(
            () => AnimatedOpacity(
              opacity: volume.value,
              duration: const Duration(milliseconds: 300),
              child: SizedBox(
                width: width * 0.5,
                height: height * 0.1,
                child: ClipOval(
                  child: Image.asset(
                    imagePath,

                    fit: BoxFit
                        .cover, // Resmin taşmasını önlemek için fit kullanın
                  ),
                ),
              ),
            ),
          ),
        ),
        Obx(
          () => SizedBox(
            width: width * 0.5,
            height: height * 0.1,
            child: Slider(
              value: volume.value,
              onChanged: setVolume,
              min: 0.0,
              max: 1.0,
            ),
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
      await audioPlayer.resume();
    }
    isPlaying.toggle();
  }

  void setVolume(double newVolume) {
    volume.value = newVolume;
    audioPlayer.setVolume(newVolume);
  }
}
