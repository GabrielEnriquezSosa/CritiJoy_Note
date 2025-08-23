import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DescriptionAnime extends ConsumerWidget {
  final String description;
  const DescriptionAnime({super.key, required this.description});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Text(
        description,
        style: TextStyle(fontSize: 15),
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
// This widget displays a description text with a maximum of 5 lines and an ellipsis for overflow.  