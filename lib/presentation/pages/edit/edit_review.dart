import 'package:critijoy_note/presentation/widgets/form_anime.dart';
import 'package:flutter/material.dart';

class EditAnime extends StatelessWidget {
  const EditAnime({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Nota - Anime',
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
