import 'package:critijoy_note/shared/ui/widgets/form_anime.dart';
import 'package:flutter/material.dart';

class EditReview extends StatefulWidget {
  const EditReview({super.key});

  @override
  State<EditReview> createState() => _EditReviewState();
}

class _EditReviewState extends State<EditReview> {
  String _category = 'Anime';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Nota - $_category',
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: 'PoetsenOne', fontSize: 22),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: FormAdd(
          onOptionSelected: (category) {
            setState(() {
              _category = category;
            });
          },
        ),
      ),
    );
  }
}
