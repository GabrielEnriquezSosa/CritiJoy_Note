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

  // Example genres
  final List<String> _availableGenres = ['Action', 'Comedy', 'Drama', 'Sci-Fi'];
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
      for (final g in genres) {
        if (!_availableGenres.contains(g)) {
          _availableGenres.add(g);
        }
      }
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
    if (!_formKey.currentState!.validate()) return;

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
                          ? const Color(0xFF1E1E1E)
                          : Colors.lightBlue.shade50.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color:
                        isDarkMode
                            ? const Color(0xFF282828)
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
                                      ? const Color(0xFF282828)
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
                              'Add Cover Image',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color:
                                    isDarkMode ? Colors.white : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'JPEG, PNG up to 5MB',
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
                      'Remove Image',
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
                color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color:
                      isDarkMode
                          ? const Color(0xFF282828)
                          : Colors.lightBlue.shade200,
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Rating',
                    style: TextStyle(
                      fontSize: 16,
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
              title: 'Title',
              hintText: 'What are you reviewing?',
              maxLength: 50,
              keyboardType: TextInputType.text,
              labelfont: 15,
              controller: _titleController,
            ),
            const SizedBox(height: 20),

            // 4. Review
            InputFormField(
              title: 'Review',
              hintText: 'Write your thoughts here...',
              maxLength: 1000,
              keyboardType: TextInputType.multiline,
              labelfont: 15,
              controller: _synopsisController,
            ),
            const SizedBox(height: 20),

            // 5. Type and Platform
            Row(
              children: [
                Expanded(
                  child: DropDownButton(
                    title: 'Type',
                    hintText: 'Select type',
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
                    title: 'Platform',
                    hintText: 'Select platform',
                    maxLength: 30,
                    keyboardType: TextInputType.text,
                    labelfont: 15,
                    controller: _platformController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 6. Genres Chips
            Text(
              'Genres',
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
                ..._availableGenres.map((genre) {
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
                        isDarkMode ? const Color(0xFF282828) : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color:
                            isSelected
                                ? Colors.lightBlue
                                : isDarkMode
                                ? const Color(0xFF282828)
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
                    'Add',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  backgroundColor:
                      isDarkMode ? const Color(0xFF141414) : Colors.white,
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
                    // Action for custom genre
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 7. Author / Studio
            InputFormField(
              title: 'Author / Studio',
              hintText: 'e.g. Studio Ghibli',
              maxLength: 50,
              keyboardType: TextInputType.text,
              labelfont: 15,
              controller: _authorController,
            ),
            const SizedBox(height: 20),

            // 8. Season, Chapters, Ep. Dur.
            Row(
              children: [
                Expanded(
                  child: InputFormField(
                    title: 'Season',
                    hintText: '-',
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    labelfont: 15,
                    controller: _seasonController,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: InputFormField(
                    title: 'Chapters',
                    hintText: '-',
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    labelfont: 15,
                    controller: _episodesController,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: InputFormField(
                    title: 'Ep. Dur.',
                    hintText: '- m',
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    labelfont: 15,
                    controller: _durationController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 9. Favorite Characters
            InputFormField(
              title: 'Favorite Characters',
              hintText: 'Separate with commas',
              maxLength: 100,
              keyboardType: TextInputType.text,
              labelfont: 15,
              controller: _charactersController,
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
                  'Save Review',
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
