import 'package:critijoy_note/features/reviews/presentation/providers/reviews_provider.dart';
import 'package:critijoy_note/shared/ui/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:critijoy_note/shared/ui/widgets/appbar_menu.dart';
import 'package:critijoy_note/shared/ui/widgets/listview_content.dart';
import 'package:critijoy_note/shared/ui/widgets/option_menu.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _selectedContentType = 'Anime'; // Default or based on dropdown

  @override
  void initState() {
    super.initState();
    // Load initial reviews
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(reviewsProvider.notifier).loadReviews(_selectedContentType);
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final reviewsAsync = ref.watch(reviewsProvider);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBarMenu(
        preferredSize: const Size(395, 60),
        child: Container(),
      ),
      body: Column(
        children: [
          OptionMenu(
            selectedType: _selectedContentType,
            onOptionSelected: (String contentType) {
              setState(() {
                _selectedContentType = contentType;
              });
              ref.read(reviewsProvider.notifier).loadReviews(contentType);
            },
          ),
          Expanded(
            child: reviewsAsync.when(
              data: (reviews) {
                if (reviews.isEmpty) {
                  return const Center(child: Text('No hay reseñas guardadas.'));
                }
                return ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    return ListViewContent(typeContenido: reviews[index]);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
      drawer: NavigationDrawerList(scaffoldKey: scaffoldKey),
    );
  }
}
