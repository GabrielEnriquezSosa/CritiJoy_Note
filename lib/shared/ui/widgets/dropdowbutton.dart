import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum OptionContenidoImpl {
  Anime,
  Peliculas,
  Caricaturas,
  RealityShow,
  Dorama,
  Telenovela,
  DibujosAnimados,
  KDrama,
  Cartoon,
  DoramaChino,
  contenidolist,
}

class DropDownButton extends ConsumerStatefulWidget {
  const DropDownButton({
    super.key,
    required this.onOptionSelected,
    this.icon,
    this.initialValue = 'Anime',
    this.title = '',
    this.hintText = '',
    this.isExpanded = true,
  });

  final void Function(String category) onOptionSelected;
  final IconData? icon;
  final String initialValue;
  final String title;
  final String hintText;
  final bool isExpanded;

  @override
  ConsumerState<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends ConsumerState<DropDownButton> {
  late TextEditingController _controller;
  late OptionContenidoImpl _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = OptionContenidoImpl.values.firstWhere(
      (e) => e.name == widget.initialValue,
      orElse: () => OptionContenidoImpl.Anime,
    );
    _controller = TextEditingController(text: _selectedOption.name);
  }

  @override
  void didUpdateWidget(DropDownButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _selectedOption = OptionContenidoImpl.values.firstWhere(
        (e) => e.name == widget.initialValue,
        orElse: () => OptionContenidoImpl.Anime,
      );
      _controller.text = _selectedOption.name;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
        DropdownMenu<OptionContenidoImpl>(
          controller: _controller,
          width: widget.isExpanded ? null : 200,
          expandedInsets: widget.isExpanded ? EdgeInsets.zero : null,
          textStyle: TextStyle(
            fontSize: 15,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
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
          onSelected: (OptionContenidoImpl? value) {
            if (value != null) {
              _controller.text = value.name;
              widget.onOptionSelected(value.name);
            }
          },
          dropdownMenuEntries:
              OptionContenidoImpl.values
                  .where(
                    (option) => option != OptionContenidoImpl.contenidolist,
                  )
                  .map(
                    (option) =>
                        DropdownMenuEntry(value: option, label: option.name),
                  )
                  .toList(),
          hintText: widget.hintText,
          trailingIcon: Icon(
            widget.icon ?? Icons.keyboard_arrow_down,
            color: Colors.blue,
          ),
          menuStyle: MenuStyle(
            padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
            backgroundColor: WidgetStatePropertyAll(
              isDarkMode ? const Color(0xFF282828) : Colors.white,
            ),
            surfaceTintColor: WidgetStatePropertyAll(
              isDarkMode ? const Color(0xFF282828) : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
