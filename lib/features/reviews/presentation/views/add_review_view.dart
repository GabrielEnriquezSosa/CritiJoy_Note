import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:critijoy_note/shared/ui/widgets/form_add.dart';

class AddReview extends ConsumerStatefulWidget {
  const AddReview({super.key});

  @override
  ConsumerState<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends ConsumerState<AddReview> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF0F1522) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        title: Text(
          'Nueva Reseña',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'PoetsenOne',
            fontSize: 22,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: const FormAdd(),
    );
  }
}
