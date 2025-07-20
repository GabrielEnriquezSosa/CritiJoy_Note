import 'package:critijoy_note/data/data_sources/review_datasources.dart';
import 'package:critijoy_note/domain/entities/review.dart';
import 'package:critijoy_note/domain/repositories/review_repositories.dart';
import 'package:flutter/material.dart';

class ReviewRepositoryImpl extends ReviewRepository {
  final ReviewDataSource dataSource;
  ReviewRepositoryImpl(this.dataSource);

  @override
  Future<void> addReview(Review review) {
    return dataSource.addReview(review);
  }

  @override
  Future<List<Review>> getReviewsByType(String type) {
    return dataSource.getReviewsByType(type);
  }

  @override
  Future<void> deleteReview(String id) {
    return dataSource.deleteReview(id);
  }
}
