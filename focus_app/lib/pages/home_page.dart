import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/audio_contoller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioController = Get.put(AudioController());

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
            Obx(
              () => GestureDetector(
                onTap: audioController.playPauseAudio,
                child: AnimatedOpacity(
                  opacity: audioController.volume.value,
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(
                    Icons.cloud,
                    size: 100,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Obx(
              () => Slider(
                value: audioController.volume.value,
                onChanged: audioController.setVolume,
                min: 0.0,
                max: 1.0,
              ),
            ),
            Obx(
              () => ElevatedButton(
                onPressed: audioController.playPauseAudio,
                child: Text(audioController.isPlaying.value ? 'Pause' : 'Play'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
