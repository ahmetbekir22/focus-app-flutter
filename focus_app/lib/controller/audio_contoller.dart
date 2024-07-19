import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioController extends GetxController {
  final List<AudioPlayer> _audioPlayers = [];
  final RxBool isPlaying = false.obs;

  void registerAudioPlayer(AudioPlayer audioPlayer) {
    _audioPlayers.add(audioPlayer);
  }

  void playAll() {
    for (var player in _audioPlayers) {
      player.resume();
    }
    isPlaying.value = true;
  }

  void pauseAll() {
    for (var player in _audioPlayers) {
      player.pause();
    }
    isPlaying.value = false;
  }
}
