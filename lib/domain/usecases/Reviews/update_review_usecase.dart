import 'package:critijoy_note/domain/entities/review.dart';
import 'package:critijoy_note/domain/repositories/review_repositories.dart';

class UpdateReviewUsecase {
  final ReviewRepository repository;
  UpdateReviewUsecase(this.repository);

  Future<void> execute(Review review) async {
    if (review.id.isEmpty) {
      throw Exception('Review id is empty');
    }

    final updateReview = review.copyWith(updateAt: DateTime.now());

    await repository.saveReview(updateReview);
  }
}
