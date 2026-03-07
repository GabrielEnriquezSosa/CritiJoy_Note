import 'package:critijoy_note/features/auth/repositories/auth_repository.dart';
import 'package:critijoy_note/features/reviews/domain/models/review.dart';

class SyncReviewsUsecase {
  final AuthRepository repository;

  SyncReviewsUsecase(this.repository);

  Future<void> execute(List<Review> reviews) {
    return repository.syncReviewsToCloud(reviews);
  }
}
