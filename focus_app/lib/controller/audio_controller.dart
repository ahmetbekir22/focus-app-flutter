import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class AudioController extends GetxController {
  var isPlaying = false.obs;
  var remainingTime = Duration.zero.obs;
  final Map<String, AudioPlayer> _audioPathToPlayer = {};
  Timer? _timer;

  void registerAudioPlayer(AudioPlayer player, String audioPath) {
    _audioPathToPlayer[audioPath] = player;
  }

  void startTimer(Duration duration) {
    remainingTime.value = duration;
    playAll();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value.inSeconds <= 0) {
        pauseAll();
        timer.cancel();
      } else {
        remainingTime.value = remainingTime.value - const Duration(seconds: 1);
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    remainingTime.value = Duration.zero;
    pauseAll();
  }

  void playAll() {
    for (var player in _audioPathToPlayer.values) {
      player.resume();
    }
    isPlaying.value = true;
  }

  void pauseAll() {
    for (var player in _audioPathToPlayer.values) {
      player.pause();
    }
    isPlaying.value = false;
  }

  void playAudio(String audioPath) {
    final player = _audioPathToPlayer[audioPath];
    player?.resume();
    isPlaying.value = true;
  }

  void pauseAudio(String audioPath) {
    final player = _audioPathToPlayer[audioPath];
    player?.pause();
  }

  // @override // I will check this later.
  // void onClose() {
  //   _timer?.cancel();
  //   super.onClose();
  // }
}
