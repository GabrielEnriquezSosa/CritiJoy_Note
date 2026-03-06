import 'package:critijoy_note/features/reviews/domain/models/review.dart';
import 'package:critijoy_note/shared/ui/widgets/form_add.dart';
import 'package:flutter/material.dart';

class EditReview extends StatefulWidget {
  final Review? review;
  const EditReview({super.key, this.review});

  @override
  State<EditReview> createState() => _EditReviewState();
}

class _EditReviewState extends State<EditReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar Reseña',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'PoetsenOne', fontSize: 22),
        ),
      ),
      body: Container(child: FormAdd(review: widget.review)),
    );
  }
}
