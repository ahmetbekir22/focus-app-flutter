import 'package:get/get.dart';

class DurationController extends GetxController {
  RxInt hours = 0.obs;
  RxInt minutes = 0.obs;
  RxInt seconds = 0.obs;

  void setInitialDuration(Duration duration) {
    hours.value = duration.inHours;
    minutes.value = duration.inMinutes % 60;
    seconds.value = duration.inSeconds % 60;
  }

  Duration get duration => Duration(
        hours: hours.value,
        minutes: minutes.value,
        seconds: seconds.value,
      );
}
