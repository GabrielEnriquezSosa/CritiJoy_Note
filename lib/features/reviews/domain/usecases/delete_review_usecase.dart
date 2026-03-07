import 'package:critijoy_note/features/reviews/domain/models/review.dart';
import 'package:critijoy_note/features/reviews/domain/repositories/review_repositories.dart';

abstract class DeleteReviewUsecase {
  final ReviewRepository repository;
  DeleteReviewUsecase(this.repository);
  Future<void> call(Review review) {
    return repository.deleteReview(review.id);
  }
}
