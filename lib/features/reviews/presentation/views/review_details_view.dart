import 'package:critijoy_note/features/reviews/domain/models/review.dart';
import 'package:critijoy_note/features/reviews/presentation/widgets/review_details_content.dart';
import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewDetailsView extends ConsumerWidget {
  final Review typeContenido;
  const ReviewDetailsView({super.key, required this.typeContenido});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF141414) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? Colors.white : const Color(0xFF1B2E4B),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Detalles de la Reseña',
          style: TextStyle(
            color: isDarkMode ? Colors.white : const Color(0xFF1B2E4B),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          // Constrains width to max 800px on larger screens (tablet/desktop) per UI best practices
          constraints: const BoxConstraints(maxWidth: 800),
          child: ReviewDetailsContent(typeContenido: typeContenido),
        ),
      ),
    );
  }
}
