import 'dart:io';

import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
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
    final cardColor = isDarkMode ? const Color(0xFF111827) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final subtitleColor = isDarkMode ? Colors.white54 : Colors.grey.shade600;

    return InkWell(
      onTap: () {
        context.push('/reviewdetails', extra: typeContenido);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDarkMode ? const Color(0xFF1F2937) : Colors.grey.shade200,
            width: 1,
          ),
          boxShadow:
              isDarkMode
                  ? []
                  : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left side Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row: Tag and Rating
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF1A56DB,
                            ).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            typeContenido.contentType.name.toUpperCase(),
                            style: const TextStyle(
                              color: Color(0xFF3B82F6), // Blue text
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        typeContenido.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Title
                  Text(
                    typeContenido.title,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // Excerpt
                  Text(
                    typeContenido.reviewText.isNotEmpty
                        ? typeContenido.reviewText
                        : 'Sin reseña',
                    style: TextStyle(
                      color: subtitleColor,
                      fontSize: 13,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),

            // Right side Image
            Container(
              width: 100, // Slightly taller/wider to match layout
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color:
                    isDarkMode ? const Color(0xFF1F2937) : Colors.grey.shade200,
              ),
              clipBehavior: Clip.hardEdge,
              child:
                  typeContenido.image.isNotEmpty &&
                          File(typeContenido.image).existsSync()
                      ? Image.file(File(typeContenido.image), fit: BoxFit.cover)
                      : Icon(
                        Icons.image_not_supported,
                        color: subtitleColor,
                        size: 30,
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
