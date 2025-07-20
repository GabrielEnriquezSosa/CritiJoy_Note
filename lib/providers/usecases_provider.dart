import 'package:critijoy_note/data/data_sources/review_fake_datasources.dart';
import 'package:critijoy_note/data/repositories/review_repository_impl.dart';
import 'package:critijoy_note/domain/usecases/get_reviews_by_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getReviewsByTypeProvider = Provider<GetReviewsByType>((ref) {
  final repository = ReviewRepositoryImpl(ReviewFakeDataSource());
  return GetReviewsByType(repository);
});
