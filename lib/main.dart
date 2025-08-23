import 'package:critijoy_note/config/router/app_router.dart';
import 'package:critijoy_note/config/theme/app_theme.dart';
import 'package:critijoy_note/presentation/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final selectedColor = ref.watch(selectedColorProvider);

    return MaterialApp.router(
      routerConfig: approuter,
      theme:
          AppTheme(
            selectedColor: selectedColor,
            isDarkMode: isDarkMode,
          ).getTheme(),
      title: 'Material App',
      debugShowCheckedModeBanner: false,
    );
  }
}
