import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenresNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  GenresNotifier()
    : super([
        {'name': 'Acción', 'icon': Icons.flash_on},
        {'name': 'Romance', 'icon': Icons.favorite},
        {'name': 'Fantasía', 'icon': Icons.auto_awesome},
        {'name': 'Recuentos de la vida', 'icon': Icons.local_cafe},
        {'name': 'Comedia', 'icon': Icons.sentiment_very_satisfied},
        {'name': 'Ciencia Ficción', 'icon': Icons.rocket_launch},
        {'name': 'Misterio', 'icon': Icons.search},
        {'name': 'Terror', 'icon': Icons.nights_stay},
      ]);

  void addGenre(String name, [IconData icon = Icons.category]) {
    final exists = state.any(
      (g) => g['name'].toString().toLowerCase() == name.toLowerCase(),
    );
    if (!exists) {
      state = [
        ...state,
        {'name': name, 'icon': icon},
      ];
    }
  }
}

final genresProvider =
    StateNotifierProvider<GenresNotifier, List<Map<String, dynamic>>>((ref) {
      return GenresNotifier();
    });
