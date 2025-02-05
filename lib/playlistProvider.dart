import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapp/songs.dart';

class PlayListProvider extends ChangeNotifier{

  final List<Song> _playlist=[
    Song(songName: "song name 1", artistName: "artist name", albumArtImagePath: "assets/images/deneme.JPG", audioPath: "audio/deneme.mp3"),
    Song(songName: "song name 2", artistName: "artist name", albumArtImagePath: "assets/images/deneme.JPG", audioPath: "audio/deneme.mp3"),
    Song(songName: "song name 3", artistName: "artist name", albumArtImagePath: "assets/images/deneme.JPG", audioPath: "audio/deneme.mp3")
  ];
  int? _currentIndex;

  List<Song> get playlist=>_playlist;
  int? get currentIndex=>_currentIndex;
  bool get isPlaying=>_isPlaying;
  Duration get currentDuration=>_currentDuration;
  Duration get totalDuration=>_totalDuration;



  set currentSongIndex(int? newIndex){
    _currentIndex=newIndex;
    if(newIndex!=null){
      play();
    }
    notifyListeners();
  }


  final AudioPlayer _audioPlayer=AudioPlayer();


  Duration _currentDuration=Duration.zero;
  Duration _totalDuration=Duration.zero;

  bool _isPlaying=false;

  PlayListProvider(){
    ListenToDuration();
  }

  void Seek(Duration position) async{
    await _audioPlayer.seek(position);
  }

  void playNextSong(){
    if(_currentIndex!=null){
      if(_currentIndex! < _playlist.length-1){
        _currentIndex=_currentIndex!+1;
        Seek(Duration.zero);
      }else{
        _currentIndex=0;
      }
    }
    notifyListeners();
  }

  void playPrevSong() async{
    if(_currentDuration.inSeconds>2){
        Seek(Duration.zero);
    }else{
      _currentIndex=_currentIndex!-1;
    }
    notifyListeners();
  }




  void ListenToDuration(){
    _audioPlayer.onDurationChanged.listen((newDuration){
      _totalDuration=newDuration;
      notifyListeners();
    });
    _audioPlayer.onPositionChanged.listen((newPosition){
      _currentDuration=newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event){
       playNextSong();
    });

  }

void play() async{
    final String path=_playlist[currentIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying=true;
    notifyListeners();
}

void pause() async{
    await _audioPlayer.pause();
    _isPlaying=false;
    notifyListeners();
}


void resume() async{
    await _audioPlayer.resume();
    _isPlaying=true;
    notifyListeners();
}

void resumeOrPause() async{
    if(_isPlaying){
       pause();
    }else{
       resume();
    }
    notifyListeners();
}

}