import 'package:critijoy_note/domain/entities/review.dart';

abstract class ReviewDataSource {
  Future<void> addReview(Review review);
  Future<List<Review>> getReviewsByType(String type);
  Future<void> deleteReview(String id);
}
