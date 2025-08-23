import 'package:critijoy_note/presentation/providers/theme_provider.dart';
import 'package:critijoy_note/presentation/widgets/dropdowbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OptionMenu extends ConsumerWidget {
  final void Function(bool anime) onOptionSelected;

  const OptionMenu({super.key, required this.onOptionSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    return SizedBox(
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.grid_view_outlined, size: 30),
            DropDownButton(
              onOptionSelected: onOptionSelected,
              icon: Icons.menu,
            ),
            IconButton(
              onPressed: () {
                ref.read(isDarkModeProvider.notifier).update((state) => !state);
              },
              icon: Icon(
                isDarkMode
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
