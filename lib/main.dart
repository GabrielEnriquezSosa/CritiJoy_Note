import 'package:critijoy_note/config/router/app_router.dart';
import 'package:critijoy_note/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: approuter,
      theme: theme(),
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      // initialRoute: '/splash',
      // routes: {
      //   "/splash": (context) => SplashScreen(),
      //   "/home": (context) => HomeScreen(),
      //   "/addreview": (context) => AddReview(),
      //   "/editanime": (context) => EditAnime(),
      // },
      // Elimina esta línea:
      // home: SplashScreen(),
    );
  }
}
