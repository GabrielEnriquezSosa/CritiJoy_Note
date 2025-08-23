import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:critijoy_note/config/theme/app_theme.dart';

final isDarkModeProvider = StateProvider<bool>((ref) => false);
final colorListProvider = Provider((ref) => colorList);
final selectedColorProvider = StateProvider<int>((ref) => 0);

final colorCardProvider = StateProvider<AppTheme>((ref) {
  final isDarkMode = ref.watch(isDarkModeProvider);
  return AppTheme(selectedModeCardColor: isDarkMode ? 7 : 6);
});
