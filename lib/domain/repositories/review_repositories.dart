import 'package:critijoy_note/domain/entities/review.dart';

abstract class ReviewRepository {
  Future<List<Review>> getReviews(String contentType);
  Future<void> saveReview(Review review);
  Future<void> deleteReview(String id);
  Future<void> getAnalitics();
  Future<void> syncgReviews();
}
