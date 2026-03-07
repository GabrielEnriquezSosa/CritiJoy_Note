import 'package:critijoy_note/features/reviews/domain/models/review.dart';
import 'package:critijoy_note/shared/ui/widgets/action_button.dart';
import 'package:critijoy_note/shared/ui/widgets/property_item.dart';
import 'package:critijoy_note/shared/ui/widgets/stars.dart';
import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:critijoy_note/shared/ui/widgets/image_anime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:critijoy_note/shared/ui/widgets/delete_confirmation_modal.dart';
import 'package:intl/intl.dart'; // Formatting date

class ReviewDetailsContent extends ConsumerWidget {
  final Review typeContenido;

  const ReviewDetailsContent({super.key, required this.typeContenido});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: ImageAnime(
                imagePath: typeContenido.image,
                height: 300,
                width: double.infinity,
                borderRadius: 16.0,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Title
          Text(
            typeContenido.title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color:
                  isDarkMode
                      ? Colors.white
                      : const Color(
                        0xFF1B2E4B,
                      ), // Dark blue text color matching mockup
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),

          // Rating Row
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              Text(
                typeContenido.rating.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0088CC), // Light blue color for rating
                  height: 1.0,
                ),
              ),
              const SizedBox(width: 8),
              const Padding(
                padding: EdgeInsets.only(bottom: 6.0),
                child:
                    Stars(), // Ideally Stars should get rating passed, but adapting to existing implementation here
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Reseñado el ${DateFormat.yMMMd().format(typeContenido.updateAt)}',
            style: TextStyle(
              fontSize: 14,
              color:
                  isDarkMode
                      ? Colors.white54
                      : Theme.of(context).primaryColor, // using primary blue
            ),
          ),
          const SizedBox(height: 16),
          Divider(
            thickness: 1,
            color:
                isDarkMode ? const Color(0xFF1F2937) : const Color(0xFFBBE1FA),
          ),
          const SizedBox(height: 16),

          // Metadata Grid
          Wrap(
            spacing: 24, // horizontal spacing between items
            runSpacing: 24, // vertical spacing between lines
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: PropertyItem(
                  label: 'Tipo',
                  value: typeContenido.contentType.name.toUpperCase(),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: PropertyItem(
                  label: 'Género',
                  value: typeContenido.genre,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: PropertyItem(
                  label: 'Plataforma',
                  value: typeContenido.platform,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: PropertyItem(
                  label: 'Autor',
                  value: typeContenido.author,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: PropertyItem(
                  label: 'Episodios',
                  value: typeContenido.chapters.toString(),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: PropertyItem(
                  label: 'Temporada',
                  value: typeContenido.season.toString(),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: PropertyItem(
                  label: 'Duración',
                  value: typeContenido.duration,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: PropertyItem(
                  label: 'Personajes',
                  value: typeContenido.personajesFavoritos.toString(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(
            thickness: 1,
            color:
                isDarkMode ? const Color(0xFF1F2937) : const Color(0xFFBBE1FA),
          ),
          const SizedBox(height: 24),

          // My Review Section
          Text(
            'Mi Reseña',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : const Color(0xFF1B2E4B),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            typeContenido.reviewText,
            style: TextStyle(
              fontSize: 16,
              color: isDarkMode ? Colors.white70 : Colors.black87,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          Divider(
            thickness: 1,
            color:
                isDarkMode ? const Color(0xFF1F2937) : const Color(0xFFBBE1FA),
          ),
          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ActionButton(
                  title: 'Editar',
                  icon: Icons.edit,
                  onPressed: () {
                    context.push('/editreview', extra: typeContenido);
                  },
                  titleColor:
                      isDarkMode ? Colors.white : const Color(0xFF0088CC),
                  iconColor:
                      isDarkMode ? Colors.white : const Color(0xFF0088CC),
                  borderColor:
                      isDarkMode
                          ? const Color(0xFF1F2937)
                          : const Color(0xFF0088CC),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ActionButton(
                  title: 'Eliminar',
                  icon: Icons.delete_outline,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) =>
                              DeleteConfirmationModal(review: typeContenido),
                    );
                  },
                  titleColor: isDarkMode ? Colors.redAccent : Colors.red,
                  iconColor: isDarkMode ? Colors.redAccent : Colors.red,
                  borderColor:
                      isDarkMode ? Colors.transparent : Colors.red.shade100,
                  backgroundColor: isDarkMode ? const Color(0xFF2C1E1E) : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 48), // Bottom padding
        ],
      ),
    );
  }
}
