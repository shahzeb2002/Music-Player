

import 'package:audioplayers/audioplayers.dart';
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


  //audio player
  final AudioPlayer _audioPlayer =AudioPlayer();


  //duration
  Duration _currentDuration=Duration.zero;
  Duration _totalDuration = Duration.zero;

  //constructor
  PlayListProvider(){
    listenToDuration();
  }

  //initially not playong
  bool _isPlaying=false;

  //play the song
  void play()async{
    final String path=_playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();//stop current song
    await _audioPlayer.play(AssetSource(path));//play new song
    _isPlaying=true;
    notifyListeners();
  }

  //pause the song
  void pause()async{
    await _audioPlayer.pause();
    _isPlaying=false;
    notifyListeners();
  }

  //resume
  void resume() async{
    await _audioPlayer.resume();
    _isPlaying=true;
    notifyListeners();
  }

  //pause or resume combining in one button
  void pauseOrResume()async{
    if(_isPlaying){
      pause();
    }else{
      resume();
    }
    notifyListeners();
  }


  //seek to specific postion
  void seek(Duration position) async{
    await _audioPlayer.seek(position);
  }

  //play next song
  void playNextSong(){
    if(_currentSongIndex!=null){
      if(_currentSongIndex !< _playlist.length -1){
        //go to next if itsnot last song
        currentSongIndex=_currentSongIndex! + 1;
      }else{
        //if it is last song loop to first song
        currentSongIndex=0;
      }
    }
  }

  //play prevoius song
  void playPreviousSong()async{
    //if more than 2 seconds have passes then restart
    if(_currentDuration.inSeconds>2){}
    //if less then 3 seconds passed then go to prevous
    else{
      if(_currentSongIndex !>0){
        currentSongIndex=_currentSongIndex! -1;
      }else{
        currentSongIndex=_playlist.length -1;
      }
    }

    }

  //listen to duartion
  void listenToDuration(){
    //listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) { 
      _totalDuration=newDuration;
      notifyListeners();
    },);
    //listen for cureent duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration=newPosition;
      notifyListeners();
    },);
    //listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
      
    },);

  }

  //dispose audio player


  //getters
  List<Song> get playlist=>_playlist;
  int? get currentSongIndex=>_currentSongIndex;
  //getter for audii
  bool get isPlaying=> _isPlaying;
  Duration get currentDuration =>_currentDuration;
  Duration get totalDuration => _totalDuration;



  //setters

  set currentSongIndex(int? newIndex){
    _currentSongIndex=newIndex;
    if(newIndex!= null){
      play();
    }
    notifyListeners();
  }




}