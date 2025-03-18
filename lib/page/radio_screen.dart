import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/radio_player.dart';
import 'package:provider/provider.dart';

class RadioPlayerScreen extends StatelessWidget {
  final List<Map<String, String>> radioStations = [
    {
      "name": "BBC World Service",
      "url": "https://stream.live.vc.bbcmedia.co.uk/bbc_world_service",
    },
    {
      "name": "Radio France",
      "url": "http://direct.franceinter.fr/live/franceinter-midfi.mp3",
    },
    {"name": "Jazz FM", "url": "http://media-ice.musicradio.com/JazzFM"},
    {"name": "Radio Tehran", "url": "http://38.96.148.20:8010"},
  ];

  RadioPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<RadioPlayerService>(context);

    return Scaffold(
      appBar: AppBar(title: Text("رادیو اینترنتی")),
      body: ListView.builder(
        itemCount: radioStations.length,
        itemBuilder: (context, index) {
          final station = radioStations[index];
          final isPlaying =
              player.isPlaying && player.currentUrl == station["url"];
          return ListTile(
            title: Text(station["name"]!),
            trailing: IconButton(
              icon: Icon(
                isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                color: Colors.blue,
              ),
              onPressed: () => player.playRadio(station["url"]!),
            ),
          );
        },
      ),
    );
  }
}
