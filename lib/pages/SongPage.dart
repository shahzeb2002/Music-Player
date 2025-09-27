import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/components/fonts.dart';
import 'package:musicplayer/components/neu_box.dart';
import 'package:musicplayer/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class Songpage extends StatelessWidget {
  const Songpage({super.key});

  //convert secongs
  String formatTime(Duration duration){
    String twoDigitSecongs=duration.inSeconds.remainder(60).toString().padLeft(2,'0');
    String formattedTime="${duration.inMinutes}: $twoDigitSecongs";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(builder: (context, value, child) {
      //get playlist
      final playlist=value.playlist;

      //get current song
      final currentSong=playlist[value.currentSongIndex ?? 0];

      //return scaffold ui
      return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          // appBar: AppBar(title: Text("Song"),centerTitle: true,),
          body:SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25,bottom: 25,top: 20),
              child: Column(

                children: [
                  //appbar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back)),

                      Text('P L A Y L I S T',style: AppTextStyles.appBar,),
                      IconButton(onPressed: () {

                      }, icon: Icon(Icons.menu)),


                    ],
                  ),
                  SizedBox(height: 35,),

                  //album
                  NeuBox(child: Column(
                    children: [
                      //album picture
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(currentSong.alburmArtImagePath)
                      ),
                      //song and artist name and icon
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //song and artist
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(currentSong.songName,style: AppTextStyles.heading),
                                Text(currentSong.artistName,style: AppTextStyles.subheading,),
                              ],
                            ),
                            //heart
                            Icon(Icons.favorite,color: Colors.red,),



                          ],),
                      )
                    ],
                  )
                  ),

                  SizedBox(height: 25,),
                  //song duration and control
                  Column(
                    children: [
                      //controls
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //start time
                            Text(formatTime(value.currentDuration)),
                            //shuffle
                            IconButton(onPressed: (){
                              value.toggleShuffle();
                            }, icon: Icon(Icons.shuffle,color: value.isShuffle?Colors.green:Colors.black,)),
                            //repear
                            Icon(Icons.repeat),

                            //end
                            Text(formatTime(value.totalDuration)),


                          ],),
                      ),
                      //durations
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0)
                        ),
                        child: Slider(
                          max: value.totalDuration.inSeconds.toDouble(),
                          min: 0,
                          activeColor: Colors.green,
                          value: value.currentDuration.inSeconds.toDouble(),
                          onChanged: (double double) {
                            //duration when dragging slider around
                          },
                          onChangeEnd: (double double) {
                            //sliding finished
                            value.seek(Duration(seconds: double.toInt()));
                          },
                        ),
                      )

                    ],
                  ),

                  SizedBox(height: 25,),

                  //playback controls
                  Row(
                    children: [
                      //skip previus
                      Expanded(child: GestureDetector(
                          onTap: value.playPreviousSong,
                          child: NeuBox(
                              child: Icon(Icons.skip_previous)
                          )
                      )
                      ),
                      SizedBox(width: 20,),

                      //play pause
                      Expanded(
                          flex: 2,
                          child: GestureDetector(
                              onTap: value.pauseOrResume,
                              child: NeuBox(
                                  child: Icon(value.isPlaying?Icons.pause :Icons.play_arrow)
                              )
                          )
                      ),

                      SizedBox(width: 20,),

                      //skip forward
                      Expanded(child: GestureDetector(
                          onTap:value.playNextSong,
                          child: NeuBox(
                              child: Icon(Icons.skip_next)
                          )
                      )
                      ),
                    ],
                  )

                ],
              ),
            ),
          )
      );
    });
  }
}
