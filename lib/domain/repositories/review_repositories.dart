import 'package:critijoy_note/domain/entities/review.dart';
import 'package:flutter/material.dart';

abstract class ReviewRepository {
  Future<void> addReview(Review review);
  Future<List<Review>> getReviewsByType(String type);
  Future<void> deleteReview(String id);
}
