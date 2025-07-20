import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:critijoy_note/presentation/widgets/appbar_menu.dart';
import 'package:critijoy_note/presentation/widgets/listview_content.dart';
import 'package:critijoy_note/presentation/widgets/option_menu.dart';
import 'package:critijoy_note/providers/review_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String tipoContenido = 'Anime';
  bool _isLoaded = false;

  void _handleOptionSelected(bool anime) {
    setState(() {
      tipoContenido = anime ? 'Anime' : 'Películas';
      ref.read(reviewControllerProvider.notifier).loadReviews(tipoContenido);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isLoaded) {
      ref.read(reviewControllerProvider.notifier).loadReviews(tipoContenido);
      _isLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final reviewsAsync = ref.watch(reviewControllerProvider);

    return Scaffold(
      appBar: AppBarMenu(
        preferredSize: const Size(395, 60),
        child: Container(),
      ),
      body: Column(
        children: [
          OptionMenu(onOptionSelected: _handleOptionSelected),
          Expanded(
            // <-- SOLUCIÓN AQUÍ
            child: reviewsAsync.when(
              data:
                  (reviews) => ListView.builder(
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      return ListViewContent(typeContenido: reviews[index]);
                    },
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }
}
