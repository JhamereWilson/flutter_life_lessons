import 'package:audioplayers/audioplayers.dart';

class AudioService {
  AudioPlayer audioPlayer = AudioPlayer();

   void play(url){
    audioPlayer.play(url);
  }
}