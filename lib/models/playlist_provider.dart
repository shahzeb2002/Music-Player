

import 'package:flutter/cupertino.dart';
import 'package:musicplayer/models/song.dart';



class PlayListProvider extends ChangeNotifier{

  final List<Song> _playlist=[
    Song(
        songName: 'SuperMan',
        artistName: 'EMINEM',
        alburmArtImagePath: "assets/images/3.jpg",
        audioPath: 'assets/audio/superman.mp3'
    ),
    Song(
        songName: 'Money',
        artistName: 'Dragons',
        alburmArtImagePath: "assets/images/2.jpg",
        audioPath: 'assets/audio/apnigarhi.mp3'
    ),
    Song(
        songName: 'Pain',
        artistName: 'Ryan Jones',
        alburmArtImagePath: "assets/images/1.jpg",
        audioPath: 'assets/audio/everyday'
    ),

  ];

  //cuurent song playing
  int? _currentSongIndex;
  //getters

  List<Song> get playlist=>_playlist;
  int? get currentSongIndex=>_currentSongIndex;



  //setters

  set currentSongIndex(int? newIndex){
    _currentSongIndex=newIndex;
    notifyListeners();
  }




}