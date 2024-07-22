// import 'dart:async';
// import 'package:get/get.dart';
// import 'package:audioplayers/audioplayers.dart';

// class AudioController extends GetxController {
//   final List<AudioPlayer> _audioPlayers = [];
//   final RxBool isPlaying = false.obs;
//   Rx<Duration> remainingTime = Duration.zero.obs;
//   Timer? _timer;

//   void registerAudioPlayer(AudioPlayer audioPlayer) {
//     _audioPlayers.add(audioPlayer);
//   }

//   void startTimer(Duration duration) {
//     remainingTime.value = duration;
//     playAll();
//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (remainingTime.value.inSeconds <= 0) {
//         pauseAll();
//         timer.cancel();
//       } else {
//         remainingTime.value = remainingTime.value - const Duration(seconds: 1);
//       }
//     });
//   }

//   void playAll() {
//     for (var player in _audioPlayers) {
//       player.resume();
//     }
//     isPlaying.value = true;
//   }

//   void pauseAll() async {
//     for (var player in _audioPlayers) {
//       await player.pause();
//     }
//     isPlaying.value = false;
//   }

//   @override
//   void onClose() {
//     _timer?.cancel();
//     super.onClose();
//   }
// }
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
  }

  void pauseAudio(String audioPath) {
    final player = _audioPathToPlayer[audioPath];
    player?.pause();
  }
}
