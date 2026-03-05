import 'package:critijoy_note/features/reviews/domain/models/review.dart';

abstract class ReviewRepository {
  Future<List<Review>> getReviews(String contentType);
  Future<void> saveReview(Review review);
  Future<void> deleteReview(String id);
  Future<void> getAnalitics();
  Future<void> syncgReviews();
}
