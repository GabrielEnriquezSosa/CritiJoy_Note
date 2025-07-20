import 'package:critijoy_note/config/theme/theme.dart';
import 'package:critijoy_note/presentation/widgets/dropdowbutton.dart';
import 'package:flutter/material.dart';

class OptionMenu extends StatelessWidget {
  final void Function(bool anime) onOptionSelected;

  const OptionMenu({super.key, required this.onOptionSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.grid_view_outlined, color: black, size: 30),
            DropDownButton(
              onOptionSelected: onOptionSelected,
              icon: Icons.menu,
            ),
            // dropdownmenu
            Icon(Icons.filter_alt_outlined, color: black, size: 30),
          ],
        ),
      ),
    );
  }
}
