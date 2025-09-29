class Song {
  final String songName;
  final String artistName;
  final String? albumArtUrl;     // API image
  final String? audioPreviewUrl; // API preview audio

  Song({
    required this.songName,
    required this.artistName,
    this.albumArtUrl,
    this.audioPreviewUrl,
  });

  // Factory constructor to map JSON → Song
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      songName: json['trackName'] ?? "Unknown",
      artistName: json['artistName'] ?? "Unknown",
      albumArtUrl: json['artworkUrl100'],   // Album art from iTunes
      audioPreviewUrl: json['previewUrl'],  // 30s preview link
    );
  }
}
