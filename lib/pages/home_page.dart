import 'package:flutter/material.dart';
import 'package:musicplayer/components/fonts.dart';
import 'package:musicplayer/components/my_drawer.dart';
import 'package:musicplayer/models/playlist_provider.dart';
import 'package:musicplayer/models/song.dart';
import 'package:musicplayer/pages/SongPage.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //getting playlist provider
  late final dynamic playListProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //get playlist provider
    playListProvider=Provider.of<PlayListProvider>(context,listen: false);
  }
  //going to particular song
  void goToSong(int songIndex){
    //update Current Index
    playListProvider.currentSongIndex=songIndex;


    //navigate to song page
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Songpage()));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Music Player',style: AppTextStyles.appBar,),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      drawer: MyDrawer(),
      body: Consumer<PlayListProvider>(
        builder: (context, value, child) {
        //getting playlist
          final List<Song> playlist=value.playlist;

          //return listview ui
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              //geting indivifaul song
              final Song song=playlist[index];

              return ListTile(
                title: Text(song.songName,style: AppTextStyles.heading,),
                subtitle: Text(song.artistName,style: AppTextStyles.subheading,),
                leading: SizedBox(
                  height: 50,width: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                        child: Image.asset(song.alburmArtImagePath,fit: BoxFit.cover,))),
                onTap: () => goToSong(index),
              );
            },
          );
        }
      ),
      
    );
  }
}
