import 'package:critijoy_note/core/database/database.dart';
import 'package:critijoy_note/features/reviews/domain/models/review.dart';
import 'package:critijoy_note/features/reviews/domain/repositories/review_repositories.dart';
import 'package:critijoy_note/shared/ui/widgets/dropdowbutton.dart';
import 'package:drift/drift.dart';

class ReviewRepositoryImpl extends ReviewRepository {
  final AppDatabase _db;

  ReviewRepositoryImpl(this._db);

  @override
  Future<void> deleteReview(String id) async {
    await (_db.delete(_db.reviews)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<void> getAnalitics() async {
    // TODO: implement getAnalitics
    throw UnimplementedError();
  }

  @override
  Future<List<Review>> getReviews(String contentType) async {
    final query = _db.select(_db.reviews)
      ..where((t) => t.contentType.equals(contentType));
    final result = await query.get();

    return result.map((row) => _mapReviewEntryToReview(row)).toList();
  }

  @override
  Future<void> saveReview(Review review) async {
    final entry = _mapReviewToReviewEntry(review);
    await _db.into(_db.reviews).insertOnConflictUpdate(entry);
  }

  @override
  Future<void> syncgReviews() async {
    // TODO: implement syncgReviews
  }

  Review _mapReviewEntryToReview(ReviewEntry entry) {
    return Review(
      id: entry.id,
      title: entry.title,
      reviewText: entry.reviewText,
      contentType: OptionContenidoImpl.values.firstWhere(
        (e) => e.name == entry.contentType,
        orElse: () => OptionContenidoImpl.Anime,
      ),
      genre: entry.genre,
      userId: entry.userId,
      platform: entry.platform,
      author: entry.author,
      rating: entry.rating,
      chapters: entry.totalEpisodes ?? 0,
      season: entry.season ?? 1,
      duration: entry.episodeDuration?.toString() ?? '',
      image: entry.imagePath,
      isSynced: entry.syncStatus == 0,
      isDeleted: entry.syncStatus == 3,
      updateAt: entry.createdAt,
      personajesFavoritos: entry.favoriteCharacters?.split(',') ?? [],
    );
  }

  ReviewsCompanion _mapReviewToReviewEntry(Review review) {
    return ReviewsCompanion(
      id: Value(review.id),
      userId: Value(review.userId),
      title: Value(review.title),
      reviewText: Value(review.reviewText),
      contentType: Value(review.contentType.name),
      genre: Value(review.genre),
      platform: Value(review.platform),
      author: Value(review.author),
      rating: Value(review.rating),
      totalEpisodes: Value(review.chapters),
      season: Value(review.season),
      episodeDuration: Value(int.tryParse(review.duration)),
      favoriteCharacters: Value(review.personajesFavoritos.join(',')),
      imagePath: Value(review.image),
      createdAt: Value(review.updateAt),
      syncStatus: Value(
        review.isDeleted ? 3 : (review.isSynced ? 0 : 1),
      ), // simple map
    );
  }
}

// Temporary helper to parse old enum style if needed
