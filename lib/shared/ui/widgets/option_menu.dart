import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:critijoy_note/shared/ui/widgets/dropdowbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OptionMenu extends ConsumerWidget {
  final String selectedType;
  final void Function(String contentType) onOptionSelected;

  const OptionMenu({
    super.key,
    required this.selectedType,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(Icons.grid_view_outlined, size: 30),
        DropDownButton(
          initialValue: selectedType,
          onOptionSelected: (String category) {
            onOptionSelected(category);
          },
          icon: Icons.menu,
        ),
        IconButton(
          onPressed: () {
            ref.read(isDarkModeProvider.notifier).update((state) => !state);
          },
          icon: Icon(
            isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
            size: 30,
          ),
        ),
      ],
    );
  }
}
