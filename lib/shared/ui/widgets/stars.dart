import 'package:critijoy_note/shared/core/theme/app_theme.dart';
import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Stars extends ConsumerWidget {
  const Stars({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final starColor = isDarkMode ? const Color(0xFF0088CC) : yellow;

    return Row(
      children: [
        Icon(Icons.star, color: starColor),
        Icon(Icons.star, color: starColor),
        Icon(Icons.star, color: starColor),
        Icon(Icons.star, color: starColor),
        Icon(Icons.star, color: starColor),
      ],
    );
  }
}

// This widget displays a row of five stars, typically used for ratings or reviews.
