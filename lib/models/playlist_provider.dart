

import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:musicplayer/models/song.dart';



class PlayListProvider extends ChangeNotifier{

  final List<Song> _playlist=[
    Song(
        songName: 'SuperMan',
        artistName: 'EMINEM',
        alburmArtImagePath: "assets/images/3.jpg",
        audioPath: 'audio/superman.mp3'
    ),
    Song(
        songName: 'Money',
        artistName: 'Dragons',
        alburmArtImagePath: "assets/images/2.jpg",
        audioPath: 'audio/apnigarhi.mp3'
    ),
    Song(
        songName: 'Pain',
        artistName: 'Ryan Jones',
        alburmArtImagePath: "assets/images/1.jpg",
        //dont include  assets  when using audio player
        audioPath: 'audio/everyday.mp3'
    ), Song(
        songName: 'All Eyes on Me',
        artistName: 'Tupac Shakur',
        alburmArtImagePath: "assets/images/tupac.jpg",
        //dont include  assets  when using audio player
        audioPath: 'audio/alleyes.mp3'
    ), Song(
        songName: 'Dusk Till Dawn',
        artistName: 'Zayn Malik',
        alburmArtImagePath: "assets/images/dusktill.jpg",
        //dont include  assets  when using audio player
        audioPath: 'audio/dusk.mp3'
    ), Song(
        songName: 'Lamhe',
        artistName: 'Mitraz',
        alburmArtImagePath: "assets/images/mitraz.jpg",
        //dont include  assets  when using audio player
        audioPath: 'audio/Lamhe.mp3'
    ), Song(
        songName: 'Nights',
        artistName: 'Tquilla',
        alburmArtImagePath: "assets/images/nights.jpg",
        //dont include  assets  when using audio player
        audioPath: 'audio/Nights.mp3'
    ), Song(
        songName: 'Something',
        artistName: 'Wizard Khalifa',
        alburmArtImagePath: "assets/images/something.jpg",
        //dont include  assets  when using audio player
        audioPath: 'audio/Something.mp3'
    ), Song(
        songName: 'Sun Flower',
        artistName: 'Post Malone',
        alburmArtImagePath: "assets/images/post.jpg",
        //dont include  assets  when using audio player
        audioPath: 'audio/Sunflower.mp3'
    ), Song(
        songName: 'You Right',
        artistName: 'Doja Cat',
        alburmArtImagePath: "assets/images/youright.jpg",
        //dont include  assets  when using audio player
        audioPath: 'audio/YouRight.mp3'
    ),Song(
        songName: 'Fair Trade',
        artistName: 'Drake',
        alburmArtImagePath: "assets/images/drake.jpg",
        //dont include  assets  when using audio player
        audioPath: 'audio/fiar.mp3'
    ),Song(
        songName: 'Everyday Normal Guy 2',
        artistName: ' JonLajoie',
        alburmArtImagePath: "assets/images/everyday.jpg",
        //dont include  assets  when using audio player
        audioPath: 'audio/normal.mp3'
    ),

  ];

  //cuurent song playing
  int? _currentSongIndex;


  //audio---------------------------------------------------------------------
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
  bool _isShuffle=false;

  //audio controls-------------------------------------------------

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
  void playNextSong() {
    if (_playlist.isEmpty) return;

    if (_isShuffle) {
      // use your shufflePlay when shuffle mode is ON
      shufflePlay();
    } else {
      // normal next
      if (_currentSongIndex == null) return;
      if (_currentSongIndex! < _playlist.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0; // loop back
      }
    }
  }

  // //play next song
  // void playNextSong(){
  //   if(_currentSongIndex!=null){
  //     if(_currentSongIndex! < _playlist.length -1){
  //       //go to next if itsnot last song
  //       currentSongIndex=_currentSongIndex! + 1;
  //     }else{
  //       //if it is last song loop to first song
  //       currentSongIndex=0;
  //     }
  //   }
  // }

  //play prevoius song
  void playPreviousSong()async{
    //if more than 2 seconds have passes then restart
    if(_currentDuration.inSeconds >2){
      seek(Duration.zero);
    }
    //if less then 3 seconds passed then go to prevous
    else{
      if(_currentSongIndex! >0){
        currentSongIndex=_currentSongIndex! -1;
      }else{
        currentSongIndex=_playlist.length -1;
      }
    }

    }
    //shuffle
  void shufflePlay() {
    if (_playlist.isEmpty) return;
    final random = Random();
    int randomIndex = random.nextInt(_playlist.length);

    // If a song is already playing, avoid repeating the same one
    if (_currentSongIndex != null && _playlist.length > 1) {
      while (randomIndex == _currentSongIndex) {
        randomIndex = random.nextInt(_playlist.length);
      }
    }
    currentSongIndex = randomIndex;
  }
  void toggleShuffle() {
    _isShuffle = !_isShuffle;
    notifyListeners();
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

  //--------------------------------------------------------------------------------------


  //getters
  List<Song> get playlist=>_playlist;
  int? get currentSongIndex=>_currentSongIndex;
  //getter for audii
  bool get isPlaying=> _isPlaying;
  Duration get currentDuration =>_currentDuration;
  Duration get totalDuration => _totalDuration;
  bool get isShuffle => _isShuffle;



  //setters

  set currentSongIndex(int? newIndex){
    _currentSongIndex=newIndex;
    if(newIndex!= null){
      play();
    }
    notifyListeners();
  }




}