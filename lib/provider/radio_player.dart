import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class RadioProvider with ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  String? _currentStation;
  String? _currentTrackTitle;
  bool _isBuffering = false;

  // لیست ایستگاه‌ها با نام، URL و آدرس تصویر
  final List<Map<String, String>> _stations = [
    {
      "name": "Radio Javan",
      "url": "https://rjstream-recent.radiojavan.com/",
      "image": "https://upload.wikimedia.org/wikipedia/en/3/35/Radio_Javan_Logo.png",
    },
    {
      "name": "BBC Persian",
      "url": "https://stream.live.vc.bbcmedia.co.uk/bbc_persian_radio",
      "image": "https://upload.wikimedia.org/wikipedia/commons/4/48/BBC_News_Persian_logo.png",
    },
    {
      "name": "VOA",
      "url": "https://voa-lh.akamaihd.net/i/voa_live@324219/master.m3u8",
      "image": "https://upload.wikimedia.org/wikipedia/commons/8/86/Voice_of_America_Logo.png",
    },
  ];

  List<Map<String, String>> get stations => _stations;
  String? get currentStation => _currentStation;
  String? get currentTrackTitle => _currentTrackTitle;
  bool get isPlaying => _player.playing;
  bool get isBuffering => _isBuffering;

  Future<void> togglePlay(String name, String url) async {
    try {
      if (_currentStation == name && _player.playing) {
        await _player.stop();
        _currentStation = null;
        _currentTrackTitle = null;
      } else {
        _isBuffering = true;
        notifyListeners();

        await _player.setUrl(url);
        _player.play();

        _currentStation = name;
        _currentTrackTitle = null;

        // گوش دادن به متادیتا
        _player.icyMetadataStream.listen((metadata) {
          final title = metadata?.info?.title;
          if (title != null && title.isNotEmpty) {
            _currentTrackTitle = title;
            notifyListeners();
          }
        });
      }
    } catch (e) {
      print("⚠️ Player error: $e");
    } finally {
      _isBuffering = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
