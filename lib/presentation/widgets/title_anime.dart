import 'package:critijoy_note/presentation/widgets/stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TitleContent extends ConsumerWidget {
  final String title;
  const TitleContent({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Column(
        children: [
          Text(
            textAlign: TextAlign.center,
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Stars(),
        ],
      ),
    );
  }
}

// This widget displays a title with a bold font and a row of stars for rating or emphasis.
