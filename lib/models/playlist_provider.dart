import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:musicplayer/models/song.dart';
import '../services/itunes_api.dart';

enum SortType { songName, artistName }

class PlayListProvider extends ChangeNotifier {
  // ========================= PLAYLIST =========================
  List<Song> _playlist = []; // fetched once
  int? _currentSongIndex;

  SortType _sortType = SortType.songName;
  String _searchQuery = "";

  bool _isLoading = false;
  String? _errorMessage;

  // ========================= AUDIO PLAYER =====================
  final AudioPlayer _audioPlayer = AudioPlayer();

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  bool _isPlaying = false;
  bool _isShuffle = false;

  // ========================= CONSTRUCTOR ======================
  PlayListProvider() {
    _listenToDuration();
  }

  // ========================= FETCH SONGS ======================
  Future<void> fetchInitialSongs([String query = "top"]) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _playlist = await ITunesApi.searchSongs(query, limit: 200);
      _sortPlaylist();
    } catch (e) {
      _errorMessage = "Error fetching songs: $e";
      if (kDebugMode) print(_errorMessage);
    }

    _isLoading = false;
    notifyListeners();
  }

  // ========================= AUDIO CONTROLS ===================
  void play() async {
    if (_currentSongIndex == null) return;
    final song = _playlist[_currentSongIndex!];

    await _audioPlayer.stop();

    if (song.audioPreviewUrl != null && song.audioPreviewUrl!.isNotEmpty) {
      await _audioPlayer.play(UrlSource(song.audioPreviewUrl!));
      _isPlaying = true;
    } else {
      _isPlaying = false;
    }

    notifyListeners();
  }

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseOrResume() {
    _isPlaying ? pause() : resume();
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void playNextSong() {
    if (_playlist.isEmpty) return;

    if (_isShuffle) {
      shufflePlay();
    } else {
      if (_currentSongIndex == null) return;
      if (_currentSongIndex! < _playlist.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0; // loop back
      }
    }
  }

  void playPreviousSong() {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex != null && _currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  void shufflePlay() {
    if (_playlist.isEmpty) return;

    final random = Random();
    int randomIndex = random.nextInt(_playlist.length);

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

  // ========================= LISTEN TO AUDIO =================
  void _listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  // ========================= SORTING ==========================
  void _sortPlaylist() {
    if (_sortType == SortType.songName) {
      _playlist.sort(
        (a, b) => a.songName.toLowerCase().compareTo(b.songName.toLowerCase()),
      );
    } else if (_sortType == SortType.artistName) {
      _playlist.sort(
        (a, b) =>
            a.artistName.toLowerCase().compareTo(b.artistName.toLowerCase()),
      );
    }
  }

  void setSortType(SortType type) {
    _sortType = type;
    _sortPlaylist();
    notifyListeners();
  }

  SortType get sortType => _sortType;

  // ========================= SEARCH ===========================
  List<Song> get filteredPlaylist {
    if (_searchQuery.isEmpty) return _playlist;
    return _playlist
        .where(
          (song) =>
              song.songName.toLowerCase().contains(_searchQuery) ||
              song.artistName.toLowerCase().contains(_searchQuery),
        )
        .toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    notifyListeners();
  }

  // ========================= GETTERS ==========================
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  bool get isShuffle => _isShuffle;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // ========================= SETTERS ==========================
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play();
    }
    notifyListeners();
  }
}
