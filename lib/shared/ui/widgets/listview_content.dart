import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:critijoy_note/shared/ui/widgets/image_anime.dart';
import 'package:critijoy_note/features/reviews/domain/models/review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ListViewContent extends ConsumerWidget {
  final Review typeContenido;
  const ListViewContent({super.key, required this.typeContenido});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return InkWell(
      onTap: () {
        context.push('/reviewdetails', extra: typeContenido);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow:
              isDarkMode
                  ? [] // Flat design in dark mode matching mockup
                  : [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
        ),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageAnime(
              imagePath: typeContenido.image,
              width: 80,
              height: 80,
              borderRadius: 12.0,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    typeContenido.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    typeContenido.contentType.name,
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          isDarkMode
                              ? Colors.grey[400]
                              : Colors.blueGrey.shade400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  typeContenido.rating.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
