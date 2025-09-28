import 'package:flutter/material.dart';
import 'package:musicplayer/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class FloatingAction extends StatelessWidget {
  const FloatingAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(builder: (context, player, child) {
      if (player.currentSongIndex==null) return SizedBox.shrink();
      return FloatingActionButton(
        onPressed: () {
        player.pauseOrResume();
      },

        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: StadiumBorder(), 
        child: Icon(player.isPlaying ? Icons.pause : Icons.play_arrow,
          size: 32,),
      );

    },);
  }
}
