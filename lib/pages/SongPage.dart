import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/components/neu_box.dart';
import 'package:musicplayer/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class Songpage extends StatelessWidget {
  const Songpage({super.key});

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

                      Text('PlayList'),
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
                                Text(currentSong.songName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                Text(currentSong.artistName),

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
                            Text('44:33'),
                            //shuffle
                            Icon(Icons.shuffle),
                            //repear
                            Icon(Icons.repeat),

                            //end
                            Text('22'),


                          ],),
                      ),
                      //durations
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0)
                        ),
                        child: Slider(
                          max: 100,
                          min: 0,
                          activeColor: Colors.green,
                          value: 60,
                          onChanged: (value) {},),
                      )

                    ],
                  ),

                  SizedBox(height: 25,),

                  //playback controls
                  Row(
                    children: [
                      //skip previus
                      Expanded(child: GestureDetector(
                          onTap: () {

                          },
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
                              onTap: () {

                              },
                              child: NeuBox(
                                  child: Icon(Icons.play_arrow)
                              )
                          )
                      ),

                      SizedBox(width: 20,),

                      //skip forward
                      Expanded(child: GestureDetector(
                          onTap: () {

                          },
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
