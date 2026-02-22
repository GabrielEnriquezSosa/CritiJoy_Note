import 'package:critijoy_note/config/theme/app_theme.dart';
import 'package:critijoy_note/domain/entities/review.dart';
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
  });

  final void Function(bool anime) onOptionSelected;
  final IconData icon;

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  Review? review;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme().getTheme().textSelectionTheme.selectionColor;
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: blue,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(width: 3, color: lightgrey),
      ),
      child: Column(
        children: [
          DropdownMenu(
            hintText:
                review?.contentType.toString() ??
                OptionContenidoImpl.Anime.toString(),
            textStyle: TextStyle(
              decoration: TextDecoration.none,
              decorationColor: colors,
              fontStyle: FontStyle.normal,
              color: colors,
            ),
            onSelected: (OptionContenidoImpl? value) {
              if (value != null) {
                if (value == OptionContenidoImpl.Anime) {
                  widget.onOptionSelected(true);
                } else if (value == OptionContenidoImpl.Peliculas) {
                  widget.onOptionSelected(false);
                } else if (value == OptionContenidoImpl.Caricaturas) {}
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
            trailingIcon: Icon(Icons.arrow_drop_down),
            menuStyle: MenuStyle(
              padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
            ),
          ),
        ],
      ),
    );
  }
}
