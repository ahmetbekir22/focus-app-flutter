import 'dart:async';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioController extends GetxController {
  final List<AudioPlayer> _audioPlayers = [];
  final RxBool isPlaying = false.obs;
  Rx<Duration> remainingTime = Duration.zero.obs;
  Timer? _timer;

  void registerAudioPlayer(AudioPlayer audioPlayer) {
    _audioPlayers.add(audioPlayer);
  }

  void startTimer(Duration duration) {
    remainingTime.value = duration;
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

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
