import 'package:critijoy_note/domain/entities/review.dart';
import 'package:critijoy_note/domain/usecases/get_reviews_by_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewController extends StateNotifier<AsyncValue<List<Review>>> {
  final GetReviewsByType getReviewsByType;

  ReviewController(this.getReviewsByType) : super(const AsyncValue.loading());

  Future<void> loadReviews(String tipo) async {
    state = const AsyncValue.loading();
    final result = await getReviewsByType(tipo);
    state = AsyncValue.data(result);
  }
}
