library quranapi;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A Calculator.
class VerseOperation {
  final audioPlayer = AudioPlayer();
  String copyVerse(
    int id_verse,
  ) {
    String copy_text = "Hello Quran";
    Clipboard.setData(ClipboardData(text: copy_text));
    return copy_text;
  }

  PlayVerse() async {
    if (audioPlayer.state != PlayerState.PLAYING) {
      await audioPlayer.play(
          'https://cdn2.islamic.network/quran/audio/128/ar.alafasy/262.mp3');
    } else {
      audioPlayer.stop();
      await audioPlayer.play(
          'https://cdn2.islamic.network/quran/audio/128/ar.alafasy/262.mp3');
    }
  }
  StopeVerse() async {
    await audioPlayer.stop();
  }
}

class Quranpage extends StatelessWidget {
  String? image;
  Quranpage({Key? key, this.image}) : super(key: key);
  List<int> ayahlentgh = [25, 11, 11, 14, 10, 8, 19, 15, 8, 16, 8];

  List<bool> ayahHiligth = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  bool selectAll = false;
  var currentayaindex;
  final verse_operation = VerseOperation();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Stack(
          children: [
            PageView(
             physics: BouncingScrollPhysics(),
              children: <Widget>[
                for (int i = 0; i < 20; i++)
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(image!), fit: BoxFit.fill),
                          ),
                          child: Stack(
                            children: [
                              StatefulBuilder(
                                builder: (context, setState) {
                                  return Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 30,
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Wrap(
                                        children: [
                                          for (int i = 0;
                                              i < ayahlentgh.length;
                                              i++)
                                            for (int j = 0;
                                                j < ayahlentgh[i];
                                                j++)
                                              GestureDetector(
                                                onLongPressEnd: (details) {
                                                  verse_operation.PlayVerse();
                                                },
                                                onLongPressStart: (details) {
                                                  print(
                                                      "aya longggggggggg number" +
                                                          "${i}");
                                                  setState(() {
                                                    ayahHiligth.fillRange(
                                                        0,
                                                        ayahHiligth.length,
                                                        false);
                                                    ayahHiligth[i] = true;
                                                    selectAll = true;
                                                    currentayaindex = i;
                                                  });
                                                },
                                                onTap: () {
                                                  print("aya number" + "${i}");
                                                  setState(() {
                                                    if (!selectAll) {
                                                      ayahHiligth.fillRange(
                                                          0,
                                                          ayahHiligth.length,
                                                          false);
                                                    } else {
                                                      if (currentayaindex !=
                                                          null) {
                                                        if (i > currentayaindex) {
                                                          ayahHiligth.fillRange(
                                                              currentayaindex,
                                                              i,
                                                              true);
                                                        } else if (i <
                                                            currentayaindex) {
                                                          ayahHiligth.fillRange(
                                                              i,
                                                              currentayaindex,
                                                              true);
                                                        }
                                                      }
                                                    }
                                                    ayahHiligth[i] = true;
                                                  });
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 1),
                                                  child: Container(
                                                      width: MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.1,
                                                      height: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.05,
                                                      color: ayahHiligth[i]
                                                          ?  Color(0x26fdd023)
                                                              .withOpacity(0.15)
                                                          : Colors.transparent,
                                                      child: SizedBox()),
                                                ),
                                              ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget PlayButton() {
  return InkWell(
    onTap: () {},
    child: Container(
      width: 120,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        color: const Color(0xff32b89c),
      ),
      child: Center(
        child: Icon(
          Icons.play_arrow,
          color: Colors.white,
        ),
      ),
    ),
  );
}


