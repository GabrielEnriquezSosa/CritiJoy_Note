import 'package:flutter/material.dart';
import 'package:critijoy_note/config/theme/theme.dart';
import 'package:critijoy_note/presentation/widgets/button.dart';
import 'package:critijoy_note/presentation/widgets/description_anime.dart';
import 'package:critijoy_note/presentation/widgets/image_anime.dart';
import 'package:critijoy_note/presentation/widgets/title_anime.dart';
import 'package:critijoy_note/domain/entities/review.dart';
import 'package:go_router/go_router.dart';

class ListViewContent extends StatelessWidget {
  final Review typeContenido;
  const ListViewContent({super.key, required this.typeContenido});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Button(
                      title: 'Editar review',
                      onPressed: () {
                        Navigator.pop(context);
                        context.push('/editreview');
                      },
                    ),
                    const SizedBox(width: 20),
                    Button(
                      title: 'Eliminar review',
                      onPressed: () {
                        Navigator.pop(context);
                        // Aquí puedes llamar a tu lógica de eliminación si lo deseas
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.5),
        color: lightgrey,
        child: Row(
          children: [
            ImageAnime(
              imagePath: typeContenido.imagen,
              width: 100,
              height: 100,
              borderRadius: 0,
            ),
            const SizedBox(width: 10),
            // Elimina el Expanded aquí
            TitleContent(title: typeContenido.titulo),
            const SizedBox(height: 5),
            DescriptionAnime(description: typeContenido.sinopsis),
          ],
        ),
      ),
    );
  }
}
