import 'package:critijoy_note/ui/pages/home/home.dart';
import 'package:critijoy_note/ui/pages/Anime/anime_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        "/anime": (context) => AnimePage(),
        "/home": (context) => ScreenHome(),
      },
      home: ScreenHome(),
    );
  }
}
