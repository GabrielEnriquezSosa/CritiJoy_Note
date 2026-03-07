import 'package:critijoy_note/features/reviews/presentation/providers/reviews_provider.dart';
import 'package:critijoy_note/shared/ui/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:critijoy_note/shared/ui/widgets/appbar_menu.dart';
import 'package:critijoy_note/shared/ui/widgets/listview_content.dart';
import 'package:critijoy_note/shared/ui/widgets/option_menu.dart';
import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _selectedContentType = 'Todo'; // Default or based on dropdown

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
    final isDarkMode = ref.watch(isDarkModeProvider);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor:
          isDarkMode ? const Color.fromARGB(25, 245, 245, 240) : null,
      appBar: AppBarMenu(
        preferredSize: const Size(double.infinity, 60),
        child: SizedBox(),
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
                  return Center(
                    child: Text(
                      'No hay reseñas guardadas.',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/addreview');
        },
        backgroundColor: Colors.blueAccent,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}
