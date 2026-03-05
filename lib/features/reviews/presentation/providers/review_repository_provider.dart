import 'package:critijoy_note/features/reviews/data/repositories/review_repository.dart';
import 'package:critijoy_note/features/reviews/domain/repositories/review_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepositoryImpl();
});
