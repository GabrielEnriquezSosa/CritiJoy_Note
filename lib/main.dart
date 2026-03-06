import 'package:critijoy_note/shared/core/router/app_router.dart';
import 'package:critijoy_note/shared/core/theme/app_theme.dart';
import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

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
