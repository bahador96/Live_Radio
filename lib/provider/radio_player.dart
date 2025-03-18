import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class RadioPlayerService with ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  String? _currentUrl;

  bool get isPlaying => _isPlaying;
  String? get currentUrl => _currentUrl;

  Future<void> playRadio(String url) async {
    try {
      if (_currentUrl == url && _isPlaying) {
        stopRadio();
        return;
      }
      await _player.setUrl(url);
      _player.play();
      _currentUrl = url;
      _isPlaying = true;
      notifyListeners();
    } catch (e) {
      debugPrint("خطا در پخش رادیو: $e");
    }
  }

  void stopRadio() {
    _player.stop();
    _isPlaying = false;
    _currentUrl = null;
    notifyListeners();
  }
}
