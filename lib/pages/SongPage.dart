import 'package:flutter/material.dart';
import 'package:musicplayer/components/fonts.dart';
import 'package:musicplayer/components/neu_box.dart';
import 'package:musicplayer/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class Songpage extends StatefulWidget {
  const Songpage({super.key});

  @override
  State<Songpage> createState() => _SongpageState();
}

class _SongpageState extends State<Songpage> {
  bool _isDragging = false;
  double _dragValue = 0.0;

  String formatTime(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(
      builder: (context, provider, child) {
        final playlist = provider.playlist;

        // if no songs available
        if (playlist.isEmpty) {
          return const Scaffold(
            body: Center(child: Text("No songs available")),
          );
        }

        final currentIndex = provider.currentSongIndex ?? 0;
        final currentSong = playlist[currentIndex];

        final totalSeconds = provider.totalDuration.inSeconds.toDouble();
        final currentSeconds = provider.currentDuration.inSeconds.toDouble();
        final sliderMax = (totalSeconds > 0) ? totalSeconds : 1.0;
        final sliderValue = _isDragging
            ? _dragValue
            : currentSeconds.clamp(0.0, sliderMax);

        // Album art widget (network or fallback)
        Widget albumArt;
        if (currentSong.albumArtUrl != null &&
            currentSong.albumArtUrl!.isNotEmpty) {
          albumArt = Image.network(
            currentSong.albumArtUrl!,
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const SizedBox(
              height: 250,
              child: Center(child: Icon(Icons.music_note, size: 80)),
            ),
          );
        } else {
          albumArt = const SizedBox(
            height: 250,
            child: Center(child: Icon(Icons.music_note, size: 80)),
          );
        }

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: 25,
                top: 20,
              ),
              child: Column(
                children: [
                  // Top bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      Text(
                        'P L A Y L I S T',
                        style: AppTextStyles.appBar(context),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Album + metadata box
                  NeuBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: albumArt,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Song + artist
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentSong.songName,
                                      style: AppTextStyles.heading(context),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      currentSong.artistName,
                                      style: AppTextStyles.subheading(context),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.favorite, color: Colors.red),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Progress / controls
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // start time
                            Text(formatTime(provider.currentDuration)),
                            // shuffle
                            IconButton(
                              onPressed: () {
                                provider.toggleShuffle();
                              },
                              icon: Icon(
                                Icons.shuffle,
                                color: provider.isShuffle
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                            ),
                            // (repeat removed — not implemented in provider)
                            // end time
                            Text(formatTime(provider.totalDuration)),
                          ],
                        ),
                      ),

                      // Slider (drag handled locally)
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 0,
                          ),
                        ),
                        child: Slider(
                          min: 0,
                          max: sliderMax,
                          value: sliderValue,
                          activeColor: Colors.green,
                          onChanged: (double value) {
                            if (provider.totalDuration.inSeconds <= 0) return;
                            setState(() {
                              _isDragging = true;
                              _dragValue = value;
                            });
                          },
                          onChangeEnd: (double value) {
                            if (provider.totalDuration.inSeconds <= 0) return;
                            provider.seek(Duration(seconds: value.toInt()));
                            setState(() {
                              _isDragging = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Playback controls (previous, play/pause, next)
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            provider.playPreviousSong();
                          },
                          child: const NeuBox(child: Icon(Icons.skip_previous)),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            provider.pauseOrResume();
                          },
                          child: NeuBox(
                            child: Icon(
                              provider.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => provider.playNextSong(),
                          child: const NeuBox(child: Icon(Icons.skip_next)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
