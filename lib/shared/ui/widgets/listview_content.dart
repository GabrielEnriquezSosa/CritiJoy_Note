import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:critijoy_note/shared/ui/widgets/button.dart';
import 'package:critijoy_note/shared/ui/widgets/description_anime.dart';
import 'package:critijoy_note/shared/ui/widgets/image_anime.dart';
import 'package:critijoy_note/shared/ui/widgets/title_anime.dart';
import 'package:critijoy_note/features/reviews/domain/models/review.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ListViewContent extends ConsumerWidget {
  final Review typeContenido;
  const ListViewContent({super.key, required this.typeContenido});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorCard = ref.watch(colorCardProvider).getTheme().cardTheme.color;
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
        color: colorCard,
        child: Row(
          children: [
            ImageAnime(
              imagePath: typeContenido.image,
              width: 100,
              height: 100,
              borderRadius: 0,
            ),
            const SizedBox(width: 10),
            TitleContent(title: typeContenido.title),
            const SizedBox(height: 5),
            DescriptionAnime(description: typeContenido.reviewText),
          ],
        ),
      ),
    );
  }
}
