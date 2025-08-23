import 'package:critijoy_note/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Stars extends StatelessWidget {
  const Stars({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: yellow),
        Icon(Icons.star, color: yellow),
        Icon(Icons.star, color: yellow),
        Icon(Icons.star, color: yellow),
        Icon(Icons.star, color: yellow),
      ],
    );
  }
}

// This widget displays a row of five yellow stars, typically used for ratings or reviews.
