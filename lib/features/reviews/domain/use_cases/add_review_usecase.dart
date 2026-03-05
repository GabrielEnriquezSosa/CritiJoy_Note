import 'package:critijoy_note/features/reviews/domain/models/review.dart';
import 'package:critijoy_note/features/reviews/domain/repositories/review_repositories.dart';
import 'package:uuid/uuid.dart';

class AddReview {
  final ReviewRepository repository;
  AddReview(this.repository);

  Future<void> execute(Review review) async {
    final newReview = review.copyWith(
      id: Uuid().v4(),
      updateAt: DateTime.now(),
    );

    await repository.saveReview(newReview);
  }
}
