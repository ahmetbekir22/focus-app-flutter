import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class AudioController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final RxBool isPlaying = false.obs;
  final RxDouble volume = 0.5.obs;

  @override
  void onInit() {
    super.onInit();
    _audioPlayer.setVolume(volume.value);
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }

  void playPauseAudio() {
    if (isPlaying.value) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play(AssetSource('sounds/rain_voice.mp3'));
    }
    isPlaying.toggle();
  }

  void setVolume(double newVolume) {
    volume.value = newVolume;
    _audioPlayer.setVolume(newVolume);
  }
}
