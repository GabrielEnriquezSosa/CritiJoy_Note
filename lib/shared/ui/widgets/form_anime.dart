import 'package:critijoy_note/features/reviews/domain/models/review.dart';
import 'package:critijoy_note/features/reviews/presentation/providers/reviews_provider.dart';
import 'package:critijoy_note/shared/core/theme/app_theme.dart';
import 'package:critijoy_note/shared/ui/widgets/dropdowbutton.dart';
import 'package:critijoy_note/shared/ui/widgets/image_anime.dart';
import 'package:critijoy_note/shared/ui/widgets/input_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class FormAdd extends ConsumerStatefulWidget {
  final void Function(String option)? onOptionSelected;

  const FormAdd({super.key, this.onOptionSelected});

  @override
  ConsumerState<FormAdd> createState() => _FormAddState();
}

class _FormAddState extends ConsumerState<FormAdd> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _synopsisController = TextEditingController();
  final _genreController = TextEditingController();
  final _platformController = TextEditingController();
  final _episodesController = TextEditingController();
  final _seasonController = TextEditingController();
  final _charactersController = TextEditingController();
  final _durationController = TextEditingController();

  String _contentType = 'Anime'; // based on DropDown
  String _imagePath = 'assets/images/anime.png'; // default

  @override
  void dispose() {
    _titleController.dispose();
    _synopsisController.dispose();
    _genreController.dispose();
    _platformController.dispose();
    _episodesController.dispose();
    _seasonController.dispose();
    _charactersController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _saveReview() {
    if (!_formKey.currentState!.validate()) return;

    // Simplistic enum parsing for contentType
    // Usually map the dropdown selection to an enum here.

    final review = Review(
      id: const Uuid().v4(),
      userId: 'user_123', // hardcoded user for now, integrate with Auth later
      title: _titleController.text.trim(),
      reviewText: _synopsisController.text.trim(),
      contentType: OptionContenidoImpl.values.firstWhere(
        (e) => e.name == _contentType,
        orElse: () => OptionContenidoImpl.Anime,
      ),
      genre: _genreController.text.trim(),
      platform: _platformController.text.trim(),
      author: 'Unknown', // add field if necessary
      rating: 0.0, // add rating bar later
      chapters: int.tryParse(_episodesController.text) ?? 0,
      season: int.tryParse(_seasonController.text) ?? 1,
      duration: _durationController.text.trim(),
      personajesFavoritos: _charactersController.text.split(','),
      image: _imagePath,
      isSynced: false,
      isDeleted: false,
      updateAt: DateTime.now(),
    );

    ref.read(reviewsProvider.notifier).addReview(review).then((_) {
      if (mounted) {
        context.pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            InputFormField(
              labelText: 'Titulo Anime/Serie:',
              maxLength: 25,
              keyboardType: TextInputType.text,
              labelfont: 20,
              controller: _titleController,
            ),
            const SizedBox(height: 10),
            InputFormField(
              labelText: 'Sipnosis:',
              maxLength: 350,
              keyboardType: TextInputType.multiline,
              labelfont: 20,
              controller: _synopsisController,
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InputFormField(
                    labelText: 'Genero:',
                    maxLength: 10,
                    keyboardType: TextInputType.text,
                    labelfont: 15,
                    controller: _genreController,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFormField(
                    labelText: 'Plataforma:',
                    maxLength: 12,
                    keyboardType: TextInputType.text,
                    labelfont: 15,
                    widht: 146,
                    controller: _platformController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InputFormField(
                    labelText: 'Total de Capitulos:',
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    labelfont: 15,
                    controller: _episodesController,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFormField(
                    labelText: 'Temporada/s:',
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    labelfont: 15,
                    controller: _seasonController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InputFormField(
                    labelText: 'Personajes Favoritos:',
                    maxLength:
                        30, // modified max length to allow multiple separated by commas
                    keyboardType: TextInputType.text,
                    labelfont: 15,
                    controller: _charactersController,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: InputFormField(
                    labelText: 'Duración de Capitulos:',
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    labelfont: 15,
                    controller: _durationController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.center,
              child: DropDownButton(
                initialValue: _contentType,
                onOptionSelected: (category) {
                  setState(() {
                    _contentType = category;
                  });
                  if (widget.onOptionSelected != null) {
                    widget.onOptionSelected!(category);
                  }
                },
                icon: Icons.menu,
              ),
            ),
            const SizedBox(height: 15),
            ImageAnime(
              imagePath: _imagePath,
              borderRadius: 10,
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(blue),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Agregar Imagen',
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(lightgrey),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Quitar Imagen',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: FilledButton(
                onPressed: _saveReview,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(darkBlue),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                child: const Text('Agregar', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
