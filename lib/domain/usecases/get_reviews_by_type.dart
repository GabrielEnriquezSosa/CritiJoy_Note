import 'package:critijoy_note/domain/entities/review.dart';
import 'package:critijoy_note/domain/repositories/review_repositories.dart';

class GetReviewsByType {
  final ReviewRepository repository;
  GetReviewsByType(this.repository);

  Future<List<Review>> call(String type) {
    return repository.getReviewsByType(type);
  }
}
