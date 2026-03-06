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
              color:
                  isDarkMode ? const Color(0xFFFFE0B2) : Colors.blue.shade200,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
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
