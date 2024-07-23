// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../components/custom_audio_widget.dart';
// import 'package:audioplayers/audioplayers.dart';
// import '../components/duration_picker.dart';
// import '../controller/audio_controller.dart';
// import 'sound_selection.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final audioController = Get.put(AudioController());

//     final List<Map<String, String>> audioFiles = [
//       {
//         'imagePath': 'assets/images/rain2.jpg',
//         'audioPath': 'sounds/rain_voice.mp3',
//         'name': 'Rain'
//       },
//       {
//         'imagePath': 'assets/images/cafe.jpeg',
//         'audioPath': 'sounds/cafe_sound.mp3',
//         'name': 'Cafe'
//       },
//       {
//         'imagePath': 'assets/images/fire-icon.jpg',
//         'audioPath': 'sounds/fire_sound.mp3',
//         'name': 'Fire'
//       },
//       {
//         'imagePath': 'assets/images/birds-icon.jpg',
//         'audioPath': 'sounds/birds_sound.mp3',
//         'name': 'Birds'
//       },
//       {
//         'imagePath': 'assets/images/waves.png',
//         'audioPath': 'sounds/waves_sound.mp3',
//         'name': 'Sea Waves'
//       },
//     ];

//     final List<AudioPlayer> audioPlayers = audioFiles.map((audioFile) {
//       final player = AudioPlayer();
//       player.setSourceAsset(audioFile['audioPath']!);
//       player.setReleaseMode(ReleaseMode.loop);
//       audioController.registerAudioPlayer(player, audioFile['audioPath']!);
//       return player;
//     }).toList();

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 105, 131, 145),
//         title: const Text(
//           'Rest Time',
//           style: TextStyle(
//             color: Color.fromARGB(255, 233, 231, 236),
//             fontSize: 23,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       ),
//       body: Container(
//         color: Colors.white,
//         child: Column(
//           children: [
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(top: Get.height * 0.01),
//                           child: IconButton(
//                             onPressed: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return DurationPicker(
//                                     initialDuration: Duration.zero,
//                                     onTimeSelected: (duration) {
//                                       audioController.startTimer(duration);
//                                     },
//                                   );
//                                 },
//                               );
//                             },
//                             icon: const Icon(Icons.timer),
//                             iconSize: 40,
//                             color: const Color.fromARGB(255, 71, 65, 65),
//                           ),
//                         ),
//                         Obx(
//                           () => Text(
//                             '${audioController.remainingTime.value.inMinutes}:${(audioController.remainingTime.value.inSeconds % 60).toString().padLeft(2, '0')}',
//                             style: const TextStyle(
//                               fontSize: 20,
//                               color: Color.fromARGB(255, 71, 65, 65),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Obx(
//                       () => IconButton(
//                         onPressed: () {
//                           if (audioController.isPlaying.value) {
//                             audioController.pauseAll();
//                           } else {
//                             audioController.playAll();
//                           }
//                         },
//                         icon: Icon(
//                           audioController.isPlaying.value
//                               ? Icons.pause
//                               : Icons.play_arrow,
//                           size: 40,
//                           color: Colors.white,
//                         ),
//                         style: ButtonStyle(
//                           shape: WidgetStateProperty.all(const CircleBorder()),
//                           backgroundColor: WidgetStateProperty.all(
//                               const Color.fromARGB(255, 71, 65, 65)),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         showDialog(
//                           context: context,
//                           builder: (context) {
//                             return SoundSelectionDialog(
//                               audioFiles: audioFiles,
//                               audioController: audioController,
//                             );
//                           },
//                         );
//                       },
//                       icon: const Icon(Icons.queue_music_outlined),
//                       iconSize: 40,
//                       color: const Color.fromARGB(255, 71, 65, 65),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                     vertical: Get.height * 0.01, horizontal: Get.width * 0.01),
//                 child: GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 20,
//                     crossAxisSpacing: 20,
//                   ),
//                   itemCount: audioFiles.length,
//                   itemBuilder: (context, index) {
//                     return CustomAudioWidget(
//                       imagePath: audioFiles[index]['imagePath']!,
//                       name: audioFiles[index]['name']!,
//                       audioPath: audioFiles[index]['audioPath']!,
//                       audioPlayer: audioPlayers[index],
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/custom_audio_widget.dart';
import 'package:audioplayers/audioplayers.dart';
import '../components/duration_picker.dart';
import '../controller/audio_controller.dart';
import 'sound_selection.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final audioController = Get.put(AudioController());

    final List<Map<String, String>> audioFiles = [
      {
        'imagePath': 'assets/images/rain2.jpg',
        'audioPath': 'sounds/rain_voice.mp3',
        'name': 'Rain'
      },
      {
        'imagePath': 'assets/images/cafe.jpeg',
        'audioPath': 'sounds/cafe_sound.mp3',
        'name': 'Cafe'
      },
      {
        'imagePath': 'assets/images/fire-icon.jpg',
        'audioPath': 'sounds/fire_sound.mp3',
        'name': 'Fire'
      },
      {
        'imagePath': 'assets/images/birds-icon.jpg',
        'audioPath': 'sounds/birds_sound.mp3',
        'name': 'Birds'
      },
      {
        'imagePath': 'assets/images/waves.png',
        'audioPath': 'sounds/waves_sound.mp3',
        'name': 'Sea Waves'
      },
    ];

    final List<AudioPlayer> audioPlayers = audioFiles.map((audioFile) {
      final player = AudioPlayer();
      player.setSourceAsset(audioFile['audioPath']!);
      player.setReleaseMode(ReleaseMode.loop);
      audioController.registerAudioPlayer(player, audioFile['audioPath']!);
      return player;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 105, 131, 145),
        title: const Text(
          'Rest Time',
          style: TextStyle(
            color: Color.fromARGB(255, 233, 231, 236),
            fontSize: 23,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.01),
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return DurationPicker(
                                    initialDuration: Duration.zero,
                                    onTimeSelected: (duration) {
                                      audioController.startTimer(duration);
                                    },
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.timer),
                            iconSize: 40,
                            color: const Color.fromARGB(255, 71, 65, 65),
                          ),
                        ),
                        Obx(
                          () => Text(
                            '${audioController.remainingTime.value.inMinutes}:${(audioController.remainingTime.value.inSeconds % 60).toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 71, 65, 65),
                            ),
                          ),
                        ),
                        Obx(
                          () => Visibility(
                            visible: audioController.remainingTime.value >
                                Duration.zero,
                            child: IconButton(
                              onPressed: () {
                                audioController.stopTimer();
                              },
                              icon: const Icon(Icons.stop),
                              iconSize: 40,
                              color: const Color.fromARGB(255, 71, 65, 65),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => IconButton(
                        onPressed: () {
                          if (audioController.isPlaying.value) {
                            audioController.pauseAll();
                          } else {
                            audioController.playAll();
                          }
                        },
                        icon: Icon(
                          audioController.isPlaying.value
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 40,
                          color: Colors.white,
                        ),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(const CircleBorder()),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 71, 65, 65)),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SoundSelectionDialog(
                              audioFiles: audioFiles,
                              audioController: audioController,
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.queue_music_outlined),
                      iconSize: 40,
                      color: const Color.fromARGB(255, 71, 65, 65),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Get.height * 0.01, horizontal: Get.width * 0.01),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  itemCount: audioFiles.length,
                  itemBuilder: (context, index) {
                    return CustomAudioWidget(
                      imagePath: audioFiles[index]['imagePath']!,
                      name: audioFiles[index]['name']!,
                      audioPath: audioFiles[index]['audioPath']!,
                      audioPlayer: audioPlayers[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
