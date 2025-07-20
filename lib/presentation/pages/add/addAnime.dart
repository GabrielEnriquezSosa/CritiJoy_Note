import 'package:flutter/material.dart';
import 'package:critijoy_note/presentation/widgets/form_anime.dart';

class AddReview extends StatelessWidget {
  const AddReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agregar Nota - Anime',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'PoetsenOne', fontSize: 22),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: FormAdd(onOptionSelected: (bool anime) {}),
      ),
    );
  }
}
