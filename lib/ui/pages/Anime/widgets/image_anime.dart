import 'package:flutter/material.dart';

class ImageAnime extends StatelessWidget {
  const ImageAnime({super.key});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage('assets/images/Logo.png'),
      width: 100,
      height: 100,
      fit: BoxFit.cover,
    );
  }
}
// This widget displays an image from the assets folder with specified dimensions and fit.