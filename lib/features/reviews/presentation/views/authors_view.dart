import 'package:critijoy_note/features/reviews/presentation/providers/reviews_provider.dart';
import 'package:critijoy_note/shared/core/theme/app_theme.dart';
import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:critijoy_note/shared/ui/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AuthorsView extends ConsumerStatefulWidget {
  const AuthorsView({super.key});

  @override
  ConsumerState<AuthorsView> createState() => _AuthorsViewState();
}

class _AuthorsViewState extends ConsumerState<AuthorsView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String searchQuery = '';
  String activeFilter = 'Todos los autores';

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final reviewsAsync = ref.watch(reviewsProvider);
    final reviews = reviewsAsync.valueOrNull ?? [];

    // Color definitions
    final backgroundColor = isDarkMode ? const Color(0xFF0F1522) : Colors.white;
    final cardColor =
        isDarkMode ? const Color(0xFF111827) : const Color(0xFFF9FAFB);
    final textColor = isDarkMode ? white : darkBlue;
    final subtitleColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];
    final borderColor = isDarkMode ? const Color(0xFF1F2937) : Colors.grey[300];

    // Calculate unique authors and their stats
    final Map<String, _AuthorData> authorDataMap = {};
    for (final review in reviews) {
      final authorName = review.author;
      if (!authorDataMap.containsKey(authorName)) {
        authorDataMap[authorName] = _AuthorData(name: authorName, genres: {});
      }
      authorDataMap[authorName]!.reviewCount++;
      authorDataMap[authorName]!.genres.add(review.genre);
    }

    var authorsList = authorDataMap.values.toList();

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      authorsList =
          authorsList
              .where(
                (author) => author.name.toLowerCase().contains(
                  searchQuery.toLowerCase(),
                ),
              )
              .toList();
    }

    if (activeFilter == 'Tendencias') {
      authorsList.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
    } else {
      authorsList.sort((a, b) => a.name.compareTo(b.name));
    }

    return Scaffold(
      key: scaffoldKey,
      drawer: NavigationDrawerList(scaffoldKey: scaffoldKey),
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Autores',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: borderColor!),
              ),
              child: TextField(
                style: TextStyle(color: textColor),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Buscar autores por nombre...',
                  hintStyle: TextStyle(color: subtitleColor),
                  prefixIcon: Icon(Icons.search, color: subtitleColor),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildFilterButton('Todos los autores', true, isDarkMode),
                const SizedBox(width: 10),
                _buildFilterButton(
                  'Tendencias',
                  false,
                  isDarkMode,
                  hasDropdown: true,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Authors List
            Expanded(
              child:
                  authorsList.isEmpty
                      ? Center(
                        child: Text(
                          'No se encontraron autores',
                          style: TextStyle(color: subtitleColor),
                        ),
                      )
                      : ListView.builder(
                        itemCount: authorsList.length,
                        itemBuilder: (context, index) {
                          final author = authorsList[index];
                          return _buildAuthorCard(
                            author,
                            isDarkMode,
                            cardColor,
                            textColor,
                            subtitleColor,
                            borderColor,
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(
    String text,
    bool isActive,
    bool isDarkMode, {
    bool hasDropdown = false,
  }) {
    final activeBgColor = isDarkMode ? const Color(0xFF1E3A8A) : lightBlue;
    final activeTextColor = isDarkMode ? Colors.blue[200] : darkBlue;

    final inactiveBgColor =
        isDarkMode ? const Color(0xFF111827) : const Color(0xFFF9FAFB);
    final inactiveTextColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];
    final borderColor = isDarkMode ? const Color(0xFF1F2937) : Colors.grey[300];

    return GestureDetector(
      onTap: () {
        setState(() {
          // Simplistic logic for filter switching
          if (!hasDropdown) {
            activeFilter = 'Todos los autores';
          } else {
            activeFilter = 'Tendencias';
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: (activeFilter == text) ? activeBgColor : inactiveBgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: (activeFilter == text) ? Colors.transparent : borderColor!,
          ),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                color:
                    (activeFilter == text)
                        ? activeTextColor
                        : inactiveTextColor,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            if (hasDropdown) ...[const SizedBox(width: 4)],
          ],
        ),
      ),
    );
  }

  Widget _buildAuthorCard(
    _AuthorData author,
    bool isDarkMode,
    Color cardColor,
    Color textColor,
    Color? subtitleColor,
    Color borderColor,
  ) {
    final genresText = author.genres.join(', ');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  author.name,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  genresText,
                  style: TextStyle(color: subtitleColor, fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${author.reviewCount}',
                style: TextStyle(
                  color: isDarkMode ? Colors.blue[400] : darkBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'RESEÑAS',
                style: TextStyle(
                  color: subtitleColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AuthorData {
  final String name;
  int reviewCount = 0;
  final Set<String> genres;

  _AuthorData({required this.name, required this.genres});
}
