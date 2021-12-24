import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:math';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicApp(),
    );
  }
}

class MusicApp extends StatefulWidget {
  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  //we will need some variables
  bool playing = false; // at the begining we are not playing any song
  IconData playBtn = Icons.play_arrow; // the main state of the play button icon

  //Now let's start by creating our music player
  //first let's declare some object
  late AudioPlayer _player;
  late AudioCache cache;

  int sn = 0;
  int last = 41;

  var songlist =
  [
    "Welcome to My Player",
    "Main Rahoon Ya Na Rahoon",
    "Agar Tum Saath Ho",
    "Soch Na Sake",
    "Samjhawan Unplugged",
    "Tumko To Aana Hi Tha",
    "I Just Wanna Spend My Life With You",
    "Main Hoon Hero Tera",
    "Sapna Jahan",
    "Mere Humsafar",
    "Kuch To Hai",
    "Bol Do Na Zara",
    "Bolna",
    "Manchala",
    "Kyun Main Jaagoon",
    "Taare Zameen Par",
    "Maa",
    "Mera Jahan",
    "Yeh Honsla",
    "Kahin To Hogi Wo",
    "Kuch Is Tarah",
    "Khudaya Ve",
    "Dil Kyun Yeh Mera",
    "Mar Jawaan",
    "Tinka Tinka Zara Zara",
    "Har Kisi Ko Nahi Milta Yahan Pyaar Zindagi Mein",
    "Kal Ho Naa Ho",
    "Na Tum Jano Na Hum",
    "Sau Dard Hain",
    "O Saiyyan",
    "Aaoge Jab Tum",
    "Noor E Khuda",
    "Baaton Ko Teri",
    "Hummein Tummein Jo Tha",
    "Raaz Aankhein Teri",
    "Tu Hi Re Tu Hi Re",
    "Jaadu Hai Nasha Hai",
    "Tera Chehra",
    "Tum Ho",
    "Suno Na Suno Na",
    "Kabhi Alvida Naa Kehna",
    "Baarish Lete Aana"
  ];

  Duration position = new Duration();
  Duration musicLength = new Duration();

  //we will create a custom slider

  Widget slider() {
    return Container(
      width: 300.0,
      child: Slider.adaptive(
          activeColor: Colors.blue[300],
          inactiveColor: Colors.grey[350],
          value: position.inSeconds.toDouble(),
          max: musicLength.inSeconds.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  //let's create the seek function that will allow us to go to a certain position of the music
  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  //Now let's initialize our player
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    //now let's handle the audioplayer time

    //this function will allow you to get the music duration
    _player.onDurationChanged.listen((Duration d) {
      setState(() {
        musicLength = d;
      });
    });

    //this function will allow us to move the cursor of the slider while we are playing the song
    _player.onAudioPositionChanged.listen((Duration p) {
      setState(() {
        position = p;
      });
    });
    _player.onPlayerStateChanged.listen((AudioPlayerState s) => {
      if (s == AudioPlayerState.COMPLETED || s == AudioPlayerState.STOPPED){
        setState((){
          if (sn == 0)
            {
              Random rnd = new Random();
              sn = 1 + rnd.nextInt(last - 1);
            }
          else if(sn==last)
            {
              sn = 1;
            }
          else
            {
              sn++;
            }
          String sngnm = songlist[sn] + ".mp3";
          cache.play(sngnm);
        })
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //let's start by creating the main UI of the app
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.black,
                Colors.black87 ,
              ]),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 48.0,
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Let's add some text title
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "My Player",
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 38.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Listen to your favorite Music",
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                //Let's add the music cover
                Center(
                  child: Container(
                    width: 280.0,
                    height: 280.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        image: DecorationImage(
                          image: AssetImage("assets/music_icon.png"),
                        )),
                  ),
                ),

                SizedBox(
                  height: 18.0,
                ),
                Center(
                  child: Text(
                    songlist[sn],
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black ,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Let's start by adding the controller
                        //let's add the time indicator text

                        Container(
                          width: 500.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${position.inMinutes}:${position.inSeconds.remainder(60)}",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              slider(),
                              Text(
                                "${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 45.0,
                              color: Colors.lightBlue,
                              onPressed: () {
                                setState(() {
                                  sn--;
                                  if(sn<1)
                                  {
                                    sn = last;
                                  }
                                  String sngnm1 = songlist[sn] + ".mp3";
                                  cache.play(sngnm1);
                                  playBtn = Icons.pause;
                                  playing = true;
                                });
                              },
                              icon: Icon(
                                Icons.skip_previous,
                              ),
                            ),
                            IconButton(
                              iconSize: 62.0,
                              color: Colors.lightBlue,
                              onPressed: () {
                                //here we will add the functionality of the play button
                                if (!playing) {
                                  //now let's play the song
                                  setState(() {
                                    playBtn = Icons.pause;
                                    playing = true;
                                    //sn++;
                                    if(sn>last)
                                    {
                                      sn = 1;
                                    }
                                    String sngnm2 = songlist[sn] + ".mp3";
                                    cache.play(sngnm2);
                                  });

                                } else {
                                  _player.pause();
                                  setState(() {
                                    playBtn = Icons.play_arrow;
                                    playing = false;
                                  });
                                }

                              },
                              icon: Icon(
                                playBtn,
                              ),
                            ),
                            IconButton(
                              iconSize: 45.0,
                              color: Colors.lightBlue,
                              onPressed: () {
                                setState(() {
                                  sn++;
                                  if(sn>last)
                                  {
                                    sn = 1;
                                  }
                                  String sngnm3 = songlist[sn] + ".mp3";
                                  cache.play(sngnm3);
                                  playBtn = Icons.pause;
                                  playing = true;
                                });
                              },
                              icon: Icon(
                                Icons.skip_next,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}