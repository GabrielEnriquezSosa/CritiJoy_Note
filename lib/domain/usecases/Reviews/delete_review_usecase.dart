import 'package:critijoy_note/domain/entities/review.dart';
import 'package:critijoy_note/domain/repositories/review_repositories.dart';

abstract class DeleteReviewUsecase {
  final ReviewRepository repository;
  DeleteReviewUsecase(this.repository);
  Future<void> call(Review review) {
    return repository.deleteReview(review.id);
  }
}
