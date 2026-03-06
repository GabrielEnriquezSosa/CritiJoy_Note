import 'package:critijoy_note/core/database/database_provider.dart';
import 'package:critijoy_note/features/reviews/data/repositories/review_repository_impl.dart';
import 'package:critijoy_note/features/reviews/domain/repositories/review_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return ReviewRepositoryImpl(db);
});
