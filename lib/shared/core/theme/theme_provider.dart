import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:critijoy_note/shared/core/theme/app_theme.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

class DarkModeNotifier extends Notifier<bool> {
  static const _key = 'darkMode';

  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getBool(_key) ?? false;
  }

  void toggleTheme(bool isDark) {
    state = isDark;
    ref.read(sharedPreferencesProvider).setBool(_key, isDark);
  }
}

final isDarkModeProvider = NotifierProvider<DarkModeNotifier, bool>(() {
  return DarkModeNotifier();
});

final colorListProvider = Provider((ref) => colorList);
final selectedColorProvider = StateProvider<int>((ref) => 0);

final colorCardProvider = StateProvider<AppTheme>((ref) {
  final isDarkMode = ref.watch(isDarkModeProvider);
  return AppTheme(selectedModeCardColor: isDarkMode ? 7 : 6);
});
