import 'dart:async';
import 'package:flutter/material.dart';
import 'package:musicplayer/components/floating_action.dart';
import 'package:musicplayer/components/fonts.dart';
import 'package:musicplayer/components/my_drawer.dart';
import 'package:musicplayer/models/playlist_provider.dart';
import 'package:musicplayer/models/song.dart';
import 'package:musicplayer/pages/SongPage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PlayListProvider playListProvider;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    playListProvider = Provider.of<PlayListProvider>(context, listen: false);

    // Fetch default songs on startup
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      debugPrint("Fetching default songs (Eminem)...");
      await playListProvider.fetchInitialSongs("eminem");
      debugPrint("Songs fetched: ${playListProvider.playlist.length}");
    });
  }

  void goToSong(int songIndex) {
    playListProvider.currentSongIndex = songIndex;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Songpage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player', style: AppTextStyles.appBar(context)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),

      drawer: const MyDrawer(),

      body: Consumer<PlayListProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          }

          final List<Song> playlist = provider.filteredPlaylist;

          if (playlist.isEmpty) {
            return const Center(
              child: Text("No songs found", style: TextStyle(fontSize: 18)),
            );
          }

          return Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search songs...",
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    // debounce search
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(
                      const Duration(milliseconds: 500),
                      () async {
                        if (value.isNotEmpty) {
                          debugPrint("Searching for: $value");
                          await provider.fetchInitialSongs(value);
                          debugPrint("Results: ${provider.playlist.length}");
                        }
                      },
                    );
                  },
                ),
              ),

              // Music List
              Expanded(
                child: ListView.builder(
                  itemCount: playlist.length,
                  itemBuilder: (context, index) {
                    final Song song = playlist[index];

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: song.albumArtUrl != null
                            ? Image.network(
                                song.albumArtUrl!,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.music_note, size: 40),
                              )
                            : const Icon(Icons.music_note, size: 40),
                      ),
                      title: Text(
                        song.songName,
                        style: AppTextStyles.heading(context),
                      ),
                      subtitle: Text(
                        song.artistName,
                        style: AppTextStyles.subheading(context),
                      ),
                      trailing: Consumer<PlayListProvider>(
                        builder: (context, provider, child) {
                          final bool isCurrentSong =
                              provider.currentSongIndex == index;
                          final bool isPlaying =
                              provider.isPlaying && isCurrentSong;

                          return IconButton(
                            icon: Icon(
                              isPlaying
                                  ? Icons.pause_circle
                                  : Icons.play_circle,
                              color: isPlaying ? Colors.green : null,
                            ),
                            onPressed: () {
                              if (isCurrentSong) {
                                provider.pauseOrResume();
                              } else {
                                provider.currentSongIndex = index;
                                provider.play();
                              }
                            },
                          );
                        },
                      ),
                      onTap: () => goToSong(index),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),

      floatingActionButton: const FloatingAction(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}
