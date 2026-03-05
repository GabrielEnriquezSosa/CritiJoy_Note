import 'package:critijoy_note/features/reviews/domain/use_cases/add_review_usecase.dart';
import 'package:critijoy_note/features/reviews/domain/use_cases/delete_review_usecase.dart';
import 'package:critijoy_note/features/reviews/domain/use_cases/get_reviews_usecase.dart';
import 'package:critijoy_note/features/reviews/domain/use_cases/sync_reviews_usecase.dart';
import 'package:critijoy_note/features/reviews/domain/use_cases/update_review_usecase.dart';
import 'package:critijoy_note/features/reviews/presentation/providers/review_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getReviewsUsecaseProvider = Provider<GetReviewsUsecase>((ref) {
  final repository = ref.watch(reviewRepositoryProvider);
  return GetReviewsUsecase(repository);
});

final addReviewUsecaseProvider = Provider<AddReview>((ref) {
  final repository = ref.watch(reviewRepositoryProvider);
  return AddReview(repository);
});

final updateReviewUsecaseProvider = Provider<UpdateReviewUsecase>((ref) {
  final repository = ref.watch(reviewRepositoryProvider);
  return UpdateReviewUsecase(repository);
});

// Assuming DeleteReviewUsecase and SyncReviewsUsecase might need concrete implementations
// if they are abstract, but from code they seem abstract without implementations yet.
// Wait, delete_review_usecase.dart has: `abstract class DeleteReviewUsecase ... Future<void> call(...) { return repository.deleteReview(...) }`
// Actually it is `abstract class DeleteReviewUsecase` but contains implementation. It shouldn't be abstract if we just instantiate it, maybe it meant `class DeleteReviewUsecase`? We will instantiate it as an anonymous subclass if needed, but let's check.
// Ah, `abstract class` cannot be instantiated. Let's create an anonymous concrete instance for now.
final deleteReviewUsecaseProvider = Provider<DeleteReviewUsecase>((ref) {
  final repository = ref.watch(reviewRepositoryProvider);
  return _DeleteReviewUsecaseImpl(repository);
});

class _DeleteReviewUsecaseImpl extends DeleteReviewUsecase {
  _DeleteReviewUsecaseImpl(super.repository);
}

final syncReviewsUsecaseProvider = Provider<SyncReviewsUsecase>((ref) {
  return _SyncReviewsUsecaseImpl();
});

class _SyncReviewsUsecaseImpl extends SyncReviewsUsecase {
  @override
  Future<void> call() async {
    // implementation
  }
}
