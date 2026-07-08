import 'package:audioplayers/audioplayers.dart';

class AudioService {
  AudioService._();

  static final AudioService instance = AudioService._();

  final AudioPlayer _player = AudioPlayer();

  Future<void> playClick() async {
    await _player.stop();

    await _player.play(
      AssetSource('images/mixkit-fast-double-click-on-mouse-275.wav'),
      volume: 0.4,
    );
  }
}