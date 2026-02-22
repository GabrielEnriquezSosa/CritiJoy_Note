import 'package:critijoy_note/domain/entities/review.dart';
import 'package:critijoy_note/domain/repositories/review_repositories.dart';

class GetReviewsUsecase {
  final ReviewRepository repository;
  GetReviewsUsecase(this.repository);

  Future<List<Review>> call(String contentType) {
    return repository.getReviews(contentType);
  }
}
