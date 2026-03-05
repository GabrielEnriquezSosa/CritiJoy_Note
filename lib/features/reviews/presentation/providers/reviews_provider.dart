import 'package:critijoy_note/features/reviews/domain/models/review.dart';
import 'package:critijoy_note/features/reviews/presentation/providers/review_usecases_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reviewsProvider = AsyncNotifierProvider<ReviewsNotifier, List<Review>>(
  () {
    return ReviewsNotifier();
  },
);

class ReviewsNotifier extends AsyncNotifier<List<Review>> {
  @override
  Future<List<Review>> build() async {
    // Default load, can be skipped or empty list initially
    return [];
  }

  Future<void> loadReviews(String contentType) async {
    state = const AsyncValue.loading();
    try {
      final getReviews = ref.read(getReviewsUsecaseProvider);
      final reviews = await getReviews(contentType);
      state = AsyncValue.data(reviews);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addReview(Review review) async {
    try {
      final addReviewUsecase = ref.read(addReviewUsecaseProvider);
      await addReviewUsecase.execute(review);
      // If we are currently showing a list of reviews, we might want to refresh it or append to current state
      final currentList = state.valueOrNull ?? [];

      // Let's pretend we refresh the list from the data source, or just add it locally
      // For simplicity, we just add locally if successful
      state = AsyncValue.data([...currentList, review]);
    } catch (e, st) {
      // Handle error, maybe rethrow or update state
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateReview(Review review) async {
    try {
      final updateReviewUsecase = ref.read(updateReviewUsecaseProvider);
      await updateReviewUsecase.execute(review);

      final currentList = state.valueOrNull ?? [];
      final updatedList =
          currentList.map((r) => r.id == review.id ? review : r).toList();
      state = AsyncValue.data(updatedList);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteReview(Review review) async {
    try {
      final deleteReviewUsecase = ref.read(deleteReviewUsecaseProvider);
      await deleteReviewUsecase(review);

      final currentList = state.valueOrNull ?? [];
      final updatedList = currentList.where((r) => r.id != review.id).toList();
      state = AsyncValue.data(updatedList);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> syncReviews() async {
    try {
      final syncReviewsUsecase = ref.read(syncReviewsUsecaseProvider);
      await syncReviewsUsecase();
      // Optional: reload reviews after sync
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
