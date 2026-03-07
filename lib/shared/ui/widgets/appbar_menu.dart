import 'package:critijoy_note/features/reviews/presentation/providers/reviews_provider.dart';
import 'package:critijoy_note/features/reviews/presentation/widgets/review_search_delegate.dart';
import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarMenu extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarMenu({
    super.key,
    required this.preferredSize,
    required this.child,
  });

  @override
  final Size preferredSize;

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Reseñas',
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: isDarkMode ? Color(0xFF3B82F6) : Colors.blue.shade200,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                final currentReviews =
                    ref.read(reviewsProvider).valueOrNull ?? [];
                if (currentReviews.isNotEmpty) {
                  showSearch(
                    context: context,
                    delegate: ReviewSearchDelegate(
                      reviews: currentReviews,
                      isDarkMode: isDarkMode,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'No hay reseñas disponibles para buscar.',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      backgroundColor:
                          isDarkMode ? Colors.grey[800] : Colors.grey[300],
                    ),
                  );
                }
              },
              icon: Icon(
                Icons.search,
                color: isDarkMode ? Colors.black87 : Colors.white,
              ),
            ),
          ),
        ),
      ],
      iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
    );
  }
}
