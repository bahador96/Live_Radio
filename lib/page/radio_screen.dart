import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/radio_player.dart';
import 'package:provider/provider.dart';

class RadioPlayerScreen extends StatelessWidget {
  const RadioPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final radioProvider = Provider.of<RadioProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text("🎧 رادیو آنلاین"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      // لیست ایستگاه‌ها
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
        child: ListView.builder(
          itemCount: radioProvider.stations.length,
          itemBuilder: (context, index) {
            final station = radioProvider.stations[index];
            final isPlaying = radioProvider.currentStation == station["name"];

            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                tileColor: isPlaying ? Colors.deepPurple[50] : Colors.white,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    station["image"] ?? "",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => const Icon(Icons.radio),
                  ),
                ),
                title: Text(
                  station["name"] ?? "بدون نام",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing:
                    radioProvider.isBuffering && isPlaying
                        ? const CircularProgressIndicator()
                        : Icon(
                          isPlaying ? Icons.stop_circle : Icons.play_circle,
                          size: 32,
                          color: Colors.deepPurple,
                        ),
                onTap:
                    () => radioProvider.togglePlay(
                      station["name"]!,
                      station["url"]!,
                    ),
              ),
            );
          },
        ),
      ),

      // نوار پخش پایین صفحه
      bottomSheet:
          radioProvider.currentStation != null
              ? Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[400],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // اطلاعات ایستگاه و آهنگ
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            radioProvider.currentStation!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (radioProvider.currentTrackTitle != null)
                            Text(
                              radioProvider.currentTrackTitle!,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    // دکمه توقف
                    IconButton(
                      icon: const Icon(
                        Icons.stop,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed:
                          () => radioProvider.togglePlay(
                            radioProvider.currentStation!,
                            radioProvider.stations.firstWhere(
                              (s) => s["name"] == radioProvider.currentStation,
                            )["url"]!,
                          ),
                    ),
                  ],
                ),
              )
              : null,
    );
  }
}
