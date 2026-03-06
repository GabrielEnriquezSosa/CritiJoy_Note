import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputFormField extends ConsumerWidget {
  final String title;
  final String hintText;
  final int maxLength;
  final double? widht;
  final double labelfont;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  const InputFormField({
    super.key,
    required this.title,
    required this.hintText,
    required this.maxLength,
    required this.keyboardType,
    this.widht,
    required this.labelfont,
    this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: keyboardType == TextInputType.multiline ? 5 : 1,
          maxLength: maxLength,
          cursorHeight: 20,
          cursorColor: isDarkMode ? Colors.white : Colors.black,
          buildCounter: (
            BuildContext context, {
            required int currentLength,
            required bool isFocused,
            required int? maxLength,
          }) {
            return null; // hide counter
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.white38 : Colors.grey.shade400,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color:
                    isDarkMode
                        ? const Color(0xFF282828)
                        : Colors.lightBlue.shade200,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.blue, width: 1.5),
            ),
          ),
          style: TextStyle(
            fontSize: 15,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}
