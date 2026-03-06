import 'package:flutter/material.dart';
import 'package:critijoy_note/shared/ui/widgets/form_anime.dart';

class AddReview extends StatefulWidget {
  const AddReview({super.key});

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  String _category = 'Anime';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agregar Nota - $_category',
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: 'PoetsenOne', fontSize: 22),
        ),
      ),
      body: FormAdd(
        onOptionSelected: (category) {
          setState(() {
            _category = category;
          });
        },
      ),
    );
  }
}
