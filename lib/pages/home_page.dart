import 'package:flutter/material.dart';
import 'package:musicplayer/components/floating_action.dart';
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
  // TextEditingController _searchController = TextEditingController();
  // String _searchQuery = "";

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
      // backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Music Player',style: AppTextStyles.appBar(context),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),

      drawer: MyDrawer(),
      body: Consumer<PlayListProvider>(
        builder: (context, value, child) {
        //getting playlist
          final List<Song> playlist=value.filteredPlaylist;
          // final filteredSongs = playlist.where((song) =>
          // song.songName.toLowerCase().contains(_searchQuery) || song.artistName.toLowerCase().contains(_searchQuery)).toList();

          //return listview ui
          return Column(
            children: [
              //search bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search songs...",
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search,),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none
                    ),
                  ),
                  onChanged: (value) {
                    context.read<PlayListProvider>().setSearchQuery(value);
                  },
                ),
              ),

              //music list

              Expanded(
                child: ListView.builder(
                  itemCount: playlist.length,
                  itemBuilder: (context, index) {
                    //geting indivifaul song
                    final Song song=playlist[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(song.songName,style: AppTextStyles.heading(context),),
                        subtitle: Text(song.artistName,style: AppTextStyles.subheading(context),),
                        leading: SizedBox(
                            height: 50,width: 50,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(song.alburmArtImagePath,fit: BoxFit.cover,))),

                        trailing: Consumer<PlayListProvider>(builder: (context, value, child) {
                          final isCurrentSong=value.currentSongIndex ==index;
                          final isPlaying=value.isPlaying &&isCurrentSong;
                          return IconButton(
                              onPressed: () {
                                if(isCurrentSong){
                                  value.pauseOrResume();
                                }else{
                                  value.currentSongIndex=index;
                                  value.play();
                                }

                              }, icon: Icon(isPlaying?Icons.pause_circle:Icons.play_circle,
                              color: isPlaying?Colors.green:null));

                        },),

                        onTap: () => goToSong(index),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      ),
      floatingActionButton: FloatingAction(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,




    );
  }
}
