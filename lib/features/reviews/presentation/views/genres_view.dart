import 'package:critijoy_note/features/reviews/presentation/providers/reviews_provider.dart';
import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'genre_details_view.dart';
import 'package:critijoy_note/features/reviews/presentation/providers/genres_provider.dart';

class GenersScreen extends ConsumerStatefulWidget {
  const GenersScreen({super.key});

  @override
  ConsumerState<GenersScreen> createState() => _GenersScreenState();
}

class _GenersScreenState extends ConsumerState<GenersScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int _getReviewCountForGenre(String genreName, WidgetRef ref) {
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

    final englishName = translationMap[genreName] ?? genreName;

    final reviewsAsync = ref.watch(reviewsProvider);
    final reviews = reviewsAsync.valueOrNull ?? [];
    return reviews.where((review) {
      final genres = review.genre.toLowerCase();
      return genres.contains(genreName.toLowerCase()) ||
          genres.contains(englishName.toLowerCase());
    }).length;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final bgColor = isDarkMode ? const Color(0xFF0F1522) : Colors.white;
    final cardColor =
        isDarkMode ? const Color(0xFF111827) : Colors.grey.shade100;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final subtitleColor = isDarkMode ? Colors.white54 : Colors.black54;

    final allGenres = ref.watch(genresProvider);

    final filteredGenres =
        allGenres.where((genre) {
          final query = _searchController.text.toLowerCase();
          final genreName = genre['name'] as String;
          return query.isEmpty || genreName.toLowerCase().contains(query);
        }).toList();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(
          'Géneros',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: textColor),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                hintText: 'Buscar géneros',
                hintStyle: TextStyle(color: subtitleColor),
                prefixIcon: Icon(Icons.search, color: subtitleColor),
                filled: true,
                fillColor: cardColor,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 30),

            // Explore Genres Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Explorar Géneros',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Grid of Genres
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.15,
                ),
                itemCount: filteredGenres.length,
                itemBuilder: (context, index) {
                  final genre = filteredGenres[index];
                  final String genreName = genre['name'] as String;
                  final IconData icon = genre['icon'] as IconData;

                  final int reviewCount = _getReviewCountForGenre(
                    genreName,
                    ref,
                  );

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  GenreDetailsView(genreName: genreName),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              isDarkMode
                                  ? const Color(0xFF1F2937)
                                  : Colors.black12,
                        ),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF1A56DB,
                              ).withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              icon,
                              color: const Color(0xFF1A56DB),
                              size: 28,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            genreName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '$reviewCount Reseña${reviewCount == 1 ? '' : 's'}',
                            style: TextStyle(
                              fontSize: 13,
                              color: subtitleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
