import 'package:critijoy_note/ui/widgets/stars.dart';
import 'package:flutter/material.dart';

class TitleAnime extends StatelessWidget {
  final String title;
  const TitleAnime({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Stars(),
      ],
    );
  }
}

// This widget displays a title with a bold font and a row of stars for rating or emphasis.
