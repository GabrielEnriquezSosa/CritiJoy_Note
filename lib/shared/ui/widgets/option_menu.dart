import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OptionMenu extends ConsumerWidget {
  final String selectedType;
  final void Function(String contentType) onOptionSelected;

  const OptionMenu({
    super.key,
    required this.selectedType,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = [
      'Todo',
      'Anime',
      'Peliculas',
      'Caricaturas',
      'RealityShow',
      'Dorama',
      'Telenovela',
      'DibujosAnimados',
      'KDrama',
      'Cartoon',
      'DoramaChino',
    ];
    final isDarkMode = ref.watch(isDarkModeProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children:
            categories.map((category) {
              final isSelected = selectedType == category;
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: InkWell(
                  onTap: () => onOptionSelected(category),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? Colors.blueAccent
                              : (isDarkMode
                                  ? const Color(0xFF282828)
                                  : Colors.blueGrey.shade50),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color:
                            isSelected
                                ? Colors.white
                                : (isDarkMode
                                    ? Colors.grey[400]
                                    : Colors.blueGrey.shade700),
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
