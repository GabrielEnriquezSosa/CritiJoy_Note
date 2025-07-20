import 'package:critijoy_note/config/theme/theme.dart';
import 'package:critijoy_note/presentation/pages/add/addAnime.dart';
import 'package:critijoy_note/presentation/pages/edit/edit_review.dart';
import 'package:critijoy_note/presentation/pages/splash/splash.dart';
import 'package:critijoy_note/presentation/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        "/splash": (context) => SplashScreen(),
        "/home": (context) => HomePage(),
        "/addreview": (context) => AddReview(),
        "/editanime": (context) => EditAnime(),
      },
      // Elimina esta línea:
      // home: SplashScreen(),
    );
  }
}
