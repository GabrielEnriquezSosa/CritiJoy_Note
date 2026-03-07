import 'dart:io';
import 'package:critijoy_note/features/reviews/domain/models/review.dart';
import 'package:critijoy_note/features/reviews/presentation/providers/reviews_provider.dart';
import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:critijoy_note/shared/ui/widgets/dropdowbutton.dart';
import 'package:critijoy_note/shared/ui/widgets/input_form_field.dart';
import 'package:critijoy_note/shared/ui/widgets/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:critijoy_note/features/reviews/presentation/providers/genres_provider.dart';

class FormAdd extends ConsumerStatefulWidget {
  final Review? review;
  const FormAdd({super.key, this.review});

  @override
  ConsumerState<FormAdd> createState() => _FormAddState();
}

class _FormAddState extends ConsumerState<FormAdd> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _synopsisController = TextEditingController();
  final _platformController = TextEditingController();
  final _authorController = TextEditingController();
  final _episodesController = TextEditingController();
  final _seasonController = TextEditingController();
  final _charactersController = TextEditingController();
  final _durationController = TextEditingController();

  String _contentType = 'Anime';
  double _rating = 0.0;
  String _imagePath = ''; // default
  final ImagePicker _picker = ImagePicker();

  // Genres
  final List<String> _selectedGenres = [];

  @override
  void initState() {
    super.initState();
    if (widget.review != null) {
      final r = widget.review!;
      _titleController.text = r.title;
      _synopsisController.text = r.reviewText;
      _platformController.text = r.platform;
      _authorController.text = r.author;
      _episodesController.text = r.chapters.toString();
      _seasonController.text = r.season.toString();
      _charactersController.text = r.personajesFavoritos.join(',');
      _durationController.text = r.duration;
      _contentType = r.contentType.name;
      _rating = r.rating;
      _imagePath = r.image;

      final genres =
          r.genre
              .split(',')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList();
      _selectedGenres.addAll(genres);
      Future.microtask(() {
        for (final g in genres) {
          ref.read(genresProvider.notifier).addGenre(g);
        }
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
    }
  }

  void _removeImage() {
    setState(() {
      _imagePath = '';
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _synopsisController.dispose();
    _platformController.dispose();
    _authorController.dispose();
    _episodesController.dispose();
    _seasonController.dispose();
    _charactersController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _saveReview() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, completa los campos obligatorios.'),
        ),
      );
      return;
    }

    if (_imagePath.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La imagen de portada es obligatoria.')),
      );
      return;
    }

    if (_rating == 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La calificación es obligatoria.')),
      );
      return;
    }

    if (_selectedGenres.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes seleccionar al menos un género.')),
      );
      return;
    }

    final review = Review(
      id: widget.review?.id ?? const Uuid().v4(),
      userId: widget.review?.userId ?? 'user_123',
      title: _titleController.text.trim(),
      reviewText: _synopsisController.text.trim(),
      contentType: OptionContenidoImpl.values.firstWhere(
        (e) => e.name == _contentType,
        orElse: () => OptionContenidoImpl.Anime,
      ),
      genre: _selectedGenres.join(', '),
      platform: _platformController.text.trim(),
      author:
          _authorController.text.trim().isNotEmpty
              ? _authorController.text.trim()
              : 'Unknown',
      rating: _rating,
      chapters: int.tryParse(_episodesController.text) ?? 0,
      season: int.tryParse(_seasonController.text) ?? 1,
      duration: _durationController.text.trim(),
      personajesFavoritos: _charactersController.text.split(','),
      image: _imagePath.isEmpty ? '' : _imagePath,
      isSynced: widget.review?.isSynced ?? false,
      isDeleted: widget.review?.isDeleted ?? false,
      updateAt: DateTime.now(),
    );

    if (widget.review != null) {
      ref.read(reviewsProvider.notifier).updateReview(review).then((_) {
        if (mounted) {
          context.pop();
        }
      });
    } else {
      ref.read(reviewsProvider.notifier).addReview(review).then((_) {
        if (mounted) {
          context.pop();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Cover Image Box
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color:
                      isDarkMode
                          ? const Color(0xFF111827)
                          : Colors.lightBlue.shade50.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color:
                        isDarkMode
                            ? const Color(0xFF1F2937)
                            : Colors.lightBlue.shade200,
                    width: 2,
                    // Note: Flutter doesn't support dashed borders natively without a package, so setting solid for now.
                  ),
                ),
                child:
                    _imagePath.isNotEmpty
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: Image.file(
                            File(_imagePath),
                            fit: BoxFit.cover,
                          ),
                        )
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  isDarkMode
                                      ? const Color(0xFF1F2937)
                                      : Colors.white,
                              radius: 25,
                              child: const Icon(
                                Icons.add_photo_alternate,
                                color: Colors.lightBlue,
                                size: 30,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Agregar Imagen de Portada',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color:
                                    isDarkMode ? Colors.white : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'JPEG, PNG hasta 5MB',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
              ),
            ),
            if (_imagePath.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _removeImage,
                    child: const Text(
                      'Eliminar Imagen',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20),

            // 2. Your Rating
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF111827) : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color:
                      isDarkMode
                          ? const Color(0xFF1F2937)
                          : Colors.lightBlue.shade200,
                  width: 1.0,
                ),
              ),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 10,
                children: [
                  Text(
                    'Tu Calificación',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                  RatingBar(
                    initialRating: _rating,
                    onRatingChanged: (val) => setState(() => _rating = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 3. Title
            InputFormField(
              title: 'Titulo',
              hintText: '¿Qué estás reseñando?',
              maxLength: 50,
              keyboardType: TextInputType.text,
              labelfont: 15,
              controller: _titleController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'El título es obligatorio';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // 4. Review
            InputFormField(
              title: 'Review',
              hintText: 'Escribe tus pensamientos aquí...',
              maxLength: 1000,
              keyboardType: TextInputType.multiline,
              labelfont: 15,
              controller: _synopsisController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'La reseña es obligatoria';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // 5. Type and Platform
            Row(
              children: [
                Expanded(
                  child: DropDownButton(
                    title: 'Tipo de Contenido',
                    hintText: 'Seleccionar tipo',
                    initialValue: _contentType,
                    onOptionSelected: (category) {
                      setState(() {
                        _contentType = category;
                      });
                    },
                    icon: Icons.keyboard_arrow_down,
                    isExpanded: true,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: InputFormField(
                    title: 'Plataforma',
                    hintText: 'Seleccionar Plataforma',
                    maxLength: 30,
                    keyboardType: TextInputType.text,
                    labelfont: 15,
                    controller: _platformController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Obligatorio';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 6. Genres Chips
            Text(
              'Generos',
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ...ref
                    .watch(genresProvider)
                    .map((g) => g['name'] as String)
                    .map((genre) {
                      final isSelected = _selectedGenres.contains(genre);
                      return FilterChip(
                        label: Text(
                          genre,
                          style: TextStyle(
                            color:
                                isSelected
                                    ? Colors.white
                                    : isDarkMode
                                    ? Colors.white
                                    : Colors.black87,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              _selectedGenres.add(genre);
                            } else {
                              _selectedGenres.remove(genre);
                            }
                          });
                        },
                        selectedColor: Colors.lightBlue,
                        backgroundColor:
                            isDarkMode ? const Color(0xFF1F2937) : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color:
                                isSelected
                                    ? Colors.lightBlue
                                    : isDarkMode
                                    ? const Color(0xFF1F2937)
                                    : Colors.lightBlue.shade200,
                          ),
                        ),
                        showCheckmark: false,
                      );
                    }),
                ActionChip(
                  avatar: Icon(
                    Icons.add,
                    size: 16,
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                  label: Text(
                    'Agregar',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  backgroundColor:
                      isDarkMode ? const Color(0xFF0F1522) : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color:
                          isDarkMode
                              ? Colors.white24
                              : Colors.lightBlue.shade200,
                      style: BorderStyle.solid,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        final newGenreController = TextEditingController();
                        return AlertDialog(
                          title: const Text('Agregar Reseña'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InputFormField(
                                title: 'Nombre del Genero',
                                hintText: 'e.g. Acción',
                                maxLength: 20,
                                keyboardType: TextInputType.text,
                                labelfont: 15,
                                controller: newGenreController,
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                final name = newGenreController.text.trim();
                                if (name.isNotEmpty) {
                                  ref
                                      .read(genresProvider.notifier)
                                      .addGenre(name);
                                }
                                Navigator.pop(context);
                              },
                              child: const Text('Agregar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 7. Author / Studio
            InputFormField(
              title: 'Autor / Estudio',
              hintText: 'e.g. Studio Ghibli',
              maxLength: 50,
              keyboardType: TextInputType.text,
              labelfont: 15,
              controller: _authorController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'El autor/estudio es obligatorio';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // 8. Season, Chapters, Ep. Dur.
            Row(
              children: [
                Expanded(
                  child: InputFormField(
                    title: 'Temporada',
                    hintText: '-',
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    labelfont: 15,
                    controller: _seasonController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Obligatorio';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: InputFormField(
                    title: 'Capitulos',
                    hintText: '-',
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    labelfont: 15,
                    controller: _episodesController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Obligatorio';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: InputFormField(
                    title: 'Cap. Dur.',
                    hintText: '- m',
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    labelfont: 15,
                    controller: _durationController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Obligatorio';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 9. Favorite Characters
            InputFormField(
              title: 'Personajes Favoritos',
              hintText: 'Separa por Comas',
              maxLength: 100,
              keyboardType: TextInputType.text,
              labelfont: 15,
              controller: _charactersController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Obligatorio';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),

            // 10. Save Review Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton.icon(
                onPressed: _saveReview,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                icon: const Icon(Icons.save, color: Colors.white),
                label: const Text(
                  'Guardar Reseña',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
