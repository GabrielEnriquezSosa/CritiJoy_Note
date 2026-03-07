import 'dart:io';

import 'package:critijoy_note/features/reviews/domain/models/review.dart';
import 'package:critijoy_note/features/reviews/presentation/providers/reviews_provider.dart';
import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GenreDetailsView extends ConsumerStatefulWidget {
  final String genreName;

  const GenreDetailsView({super.key, required this.genreName});

  @override
  ConsumerState<GenreDetailsView> createState() => _GenreDetailsViewState();
}

class _GenreDetailsViewState extends ConsumerState<GenreDetailsView> {
  String _dateFilter = 'Recientes';
  String _ratingFilter = 'Mejor calificados';
  String _activeSort = 'date'; // 'date' or 'rating'

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final bgColor =
        isDarkMode ? const Color(0xFF0F1522) : const Color(0xFFF5F6F8);
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    final reviewsAsync = ref.watch(reviewsProvider);
    final allReviews = reviewsAsync.valueOrNull ?? [];

    final Map<String, String> translationMap = {
      'Acción': 'Action',
      'Romance': 'Romance',
      'Fantasía': 'Fantasy',
      'Recuentos de la vida': 'Slice of Life',
      'Comedia': 'Comedy',
      'Ciencia Ficción': 'Sci-Fi',
      'Misterio': 'Mystery',
      'Terror': 'Horror',
    };
    final englishName = translationMap[widget.genreName] ?? widget.genreName;

    final filteredReviews =
        allReviews.where((review) {
          final genres = review.genre.toLowerCase();
          return genres.contains(widget.genreName.toLowerCase()) ||
              genres.contains(englishName.toLowerCase());
        }).toList();

    // Apply Sorting
    filteredReviews.sort((a, b) {
      if (_activeSort == 'date') {
        if (_dateFilter == 'Recientes') {
          return b.updateAt.compareTo(a.updateAt);
        } else {
          return a.updateAt.compareTo(b.updateAt);
        }
      } else {
        if (_ratingFilter == 'Mejor calificados') {
          return b.rating.compareTo(a.rating);
        } else {
          return a.rating.compareTo(b.rating);
        }
      }
    });

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.genreName,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: textColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter row
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _FilterButton(
                    title: _dateFilter,
                    isSelected: _activeSort == 'date',
                    isDarkMode: isDarkMode,
                    options: const ['Recientes', 'Antiguos'],
                    onSelected: (val) {
                      setState(() {
                        _dateFilter = val;
                        _activeSort = 'date';
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _FilterButton(
                    title: _ratingFilter,
                    isSelected: _activeSort == 'rating',
                    isDarkMode: isDarkMode,
                    options: const ['Mejor calificados', 'Peor calificados'],
                    onSelected: (val) {
                      setState(() {
                        _ratingFilter = val;
                        _activeSort = 'rating';
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // Reviews List
          Expanded(
            child:
                filteredReviews.isEmpty
                    ? Center(
                      child: Text(
                        'No hay reseñas para este género aún.',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white54 : Colors.black54,
                        ),
                      ),
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: filteredReviews.length,
                      itemBuilder: (context, index) {
                        return _GenreReviewCard(
                          review: filteredReviews[index],
                          isDarkMode: isDarkMode,
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final bool isDarkMode;
  final List<String> options;
  final ValueChanged<String> onSelected;

  const _FilterButton({
    required this.title,
    required this.isSelected,
    required this.isDarkMode,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor =
        isSelected
            ? const Color(0xFF1E50D8) // Bright primary blue
            : (isDarkMode
                ? const Color(0xFF1F2937)
                : const Color(0xFFEDEEF0)); // Dark grey inactive
    final textColor =
        isSelected
            ? Colors.white
            : (isDarkMode ? Colors.white70 : Colors.black87);

    return PopupMenuButton<String>(
      onSelected: onSelected,
      color: isDarkMode ? const Color(0xFF1F2937) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      offset: const Offset(0, 45), // Position below the button
      itemBuilder: (BuildContext context) {
        return options.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(
              choice,
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black87,
                fontSize: 14,
              ),
            ),
          );
        }).toList();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20), // Pill shape requested
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: 12, // slightly smaller to fit better
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 2),
            Icon(Icons.keyboard_arrow_down, size: 14, color: textColor),
          ],
        ),
      ),
    );
  }
}

class _GenreReviewCard extends StatelessWidget {
  final Review review;
  final bool isDarkMode;

  const _GenreReviewCard({required this.review, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final cardColor = isDarkMode ? const Color(0xFF111827) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final subtitleColor = isDarkMode ? Colors.white54 : Colors.grey.shade600;

    return InkWell(
      onTap: () {
        context.push('/reviewdetails', extra: review);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
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
                            review.contentType.name.toUpperCase(),
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
                        review.rating.toStringAsFixed(1),
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
                    review.title,
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
                    review.reviewText,
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
                  review.image.isNotEmpty && File(review.image).existsSync()
                      ? Image.file(File(review.image), fit: BoxFit.cover)
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
