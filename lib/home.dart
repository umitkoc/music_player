import 'package:flutter/material.dart';
import 'package:myapp/music_page.dart';
import 'package:myapp/my_drawer.dart';
import 'package:myapp/playlistProvider.dart';
import 'package:myapp/songs.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final dynamic playlistProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playlistProvider=Provider.of<PlayListProvider>(context,listen: false);
  }

void goToSong(int songIndex){
playlistProvider.currentSongIndex=songIndex;
Navigator.push(context, MaterialPageRoute(builder: (context)=>MusicPage()));
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: Text("N E O P L A Y"),centerTitle: true,),
      drawer: const MyDrawer(),
      body: Consumer<PlayListProvider>(builder: (context,value,child){
        final List<Song> playlist=value.playlist;
       return  ListView.builder(
           itemCount: playlist.length,
           itemBuilder: (context,index){
         final Song song=playlist[index];

         return ListTile(
           title: Text(song.songName),
           subtitle: Text(song.artistName),
           leading:Image.asset(song.albumArtImagePath),
           onTap: (){
             goToSong(index);
           },

         );
       });

      }));
  }
}
