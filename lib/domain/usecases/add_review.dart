import 'package:critijoy_note/domain/entities/review.dart';
import 'package:critijoy_note/domain/repositories/review_repositories.dart';
import 'package:flutter/material.dart';

class AddReview {
  final ReviewRepository repository;
  AddReview(this.repository);

  Future<void> call(Review review) {
    return repository.addReview(review);
  }
}
