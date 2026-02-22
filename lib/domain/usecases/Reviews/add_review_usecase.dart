import 'package:critijoy_note/domain/entities/review.dart';
import 'package:critijoy_note/domain/repositories/review_repositories.dart';
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
