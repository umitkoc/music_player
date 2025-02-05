import 'package:flutter/material.dart';
import 'package:myapp/home.dart';
import 'package:myapp/neu_box.dart';
import 'package:myapp/playlistProvider.dart';
import 'package:provider/provider.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  String formatTime(Duration duration){
    String twoDigitSeconds=duration.inSeconds.remainder(60).toString();
    return "${duration.inMinutes}:$twoDigitSeconds";
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(builder: (context,value,child) {
      final playList=value.playlist;

      final currentSong=playList[value.currentIndex??0];
      return Scaffold(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .surface,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
              child: Column(children: [

                const SizedBox(height: 20,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage())),
                          icon: Icon(Icons.arrow_back)),

                      Text("P L A Y L I S T"),

                      IconButton(onPressed: ()=>showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Application Info'),
                          content: const Text('Application Version'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      ),
                          icon: Icon(Icons.info)),


                    ]
                ),
                const SizedBox(height: 20,),
                NeuBox(child: Column(
                  children: [
                    ClipRect(child:Image.asset(currentSong.albumArtImagePath)),

                  ],
                )),
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                              [
                                Text(currentSong.songName, style: TextStyle(fontSize: 20,
                                    fontWeight: FontWeight.bold),),
                                Text(currentSong.artistName)
                              ]
                          )
                        ]
                    )
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formatTime(value.currentDuration)),
                      Icon(Icons.shuffle),
                      Icon(Icons.repeat),
                      Text(formatTime(value.totalDuration)),

                    ],),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 0)),
                    child: Slider(
                        min: 0,
                        max: value.totalDuration.inSeconds.toDouble(),
                        activeColor: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                        value: value.currentDuration.inSeconds.toDouble(),
                        onChanged: (double double) {

                        },onChangeEnd: (double double){
                          value.Seek(Duration(seconds: double.toInt()));
                    },),

                  ),
                ),
                const SizedBox(height: 10,)

                , Row(children: [
                  Expanded(child: GestureDetector(
                      onTap: () =>value.playPrevSong(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NeuBox(
                            child: Icon(Icons.skip_previous_outlined)),
                      ))),
                  Expanded(child: GestureDetector(
                      onTap: () =>value.resumeOrPause(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NeuBox(child: value.isPlaying?Icon(Icons.play_arrow_outlined):Icon(Icons.pause_outlined)),
                      ))),
                  Expanded(child: GestureDetector(
                      onTap: () =>value.playNextSong(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NeuBox(child: Icon(Icons.skip_next_outlined)),
                      )))


                ],)
              ]
              ),
            ),
          ));

    });
  }
}
