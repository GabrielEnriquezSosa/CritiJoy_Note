import 'package:critijoy_note/features/reviews/domain/models/review.dart';
import 'package:critijoy_note/shared/ui/widgets/listview_content.dart';
import 'package:flutter/material.dart';

class ReviewSearchDelegate extends SearchDelegate<Review?> {
  final List<Review> reviews;
  final bool isDarkMode;

  ReviewSearchDelegate({required this.reviews, required this.isDarkMode});

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkMode ? const Color(0xFF0F1522) : Colors.white,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: isDarkMode ? Colors.white54 : Colors.black54,
        ),
        border: InputBorder.none,
      ),
      textTheme: theme.textTheme.copyWith(
        titleLarge: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
      ),
    );
  }

  @override
  String get searchFieldLabel => 'Buscar reseñas...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final searchResults =
        reviews.where((review) {
          final titleLower = review.title.toLowerCase();
          final queryLower = query.toLowerCase();
          return titleLower.contains(queryLower);
        }).toList();

    if (searchResults.isEmpty) {
      return Center(
        child: Text(
          'No se encontraron resultados.',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      );
    }

    return Container(
      color: isDarkMode ? const Color(0xFF0F1522) : Colors.white,
      child: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final review = searchResults[index];
          return ListViewContent(typeContenido: review);
        },
      ),
    );
  }
}
