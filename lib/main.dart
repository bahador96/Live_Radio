import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/radio_screen.dart';
import 'package:flutter_application_1/provider/radio_player.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => RadioPlayerService(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RadioPlayerScreen(),
    );
  }
}
