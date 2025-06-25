import 'package:flutter/material.dart';

class DescriptionAnime extends StatelessWidget {
  final String description;
  const DescriptionAnime({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        description,
        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
// This widget displays a description text with a maximum of 5 lines and an ellipsis for overflow.