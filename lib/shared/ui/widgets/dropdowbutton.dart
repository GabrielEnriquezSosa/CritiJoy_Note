import 'package:critijoy_note/shared/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

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

class DropDownButton extends StatefulWidget {
  const DropDownButton({
    super.key,
    required this.onOptionSelected,
    required this.icon,
    this.initialValue = 'Anime',
  });

  final void Function(String category) onOptionSelected;
  final IconData icon;
  final String initialValue;

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
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
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: blue,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(width: 3, color: lightgrey),
      ),
      child: Column(
        children: [
          DropdownMenu<OptionContenidoImpl>(
            controller: _controller,
            textStyle: const TextStyle(
              decoration: TextDecoration.none,
              decorationColor: Colors.white,
              fontStyle: FontStyle.normal,
              color: Colors.white,
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
            trailingIcon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            ),
            menuStyle: const MenuStyle(
              padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
            ),
          ),
        ],
      ),
    );
  }
}
