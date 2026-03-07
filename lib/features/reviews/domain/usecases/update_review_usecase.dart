import 'package:critijoy_note/features/reviews/domain/models/review.dart';
import 'package:critijoy_note/features/reviews/domain/repositories/review_repositories.dart';

class UpdateReviewUsecase {
  final ReviewRepository repository;
  UpdateReviewUsecase(this.repository);

  Future<void> execute(Review review) async {
    if (review.id.isEmpty) {
      throw Exception('Reseña no encontrada');
    }

    final updateReview = review.copyWith(updateAt: DateTime.now());

    await repository.saveReview(updateReview);
  }
}
