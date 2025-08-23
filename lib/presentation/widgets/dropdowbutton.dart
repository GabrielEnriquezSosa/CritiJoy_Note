import 'package:critijoy_note/config/theme/app_theme.dart';
import 'package:critijoy_note/data/models/contenido_model.dart';
import 'package:flutter/material.dart';

class DropDownButton extends StatelessWidget {
  const DropDownButton({
    super.key,
    required this.onOptionSelected,
    required this.icon,
  });

  final void Function(bool anime) onOptionSelected;
  final IconData icon;

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
            hintText: OptionContenidoImplList.contenidolist[0].type,
            textStyle: TextStyle(
              decoration: TextDecoration.none,
              decorationColor: colors,
              fontStyle: FontStyle.normal,
              color: colors,
            ),
            onSelected: (OptionContenidoImpl? value) {
              if (value != null) {
                if (value.type == 'Anime') {
                  onOptionSelected(true);
                } else if (value.type == 'Peliculas') {
                  onOptionSelected(false);
                } else if (value.type == 'Caricaturas') {}
              }
            },
            dropdownMenuEntries:
                OptionContenidoImplList.contenidolist
                    .map(
                      (menu) => DropdownMenuEntry<OptionContenidoImpl>(
                        value: menu,
                        label: menu.type,
                        leadingIcon: Icon(menu.icon, color: colors),
                      ),
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
