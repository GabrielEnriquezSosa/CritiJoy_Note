import '../models/analytics_data.dart';
import '../repositories/review_repositories.dart';

class GetAnalyticsUsecase {
  final ReviewRepository repository;

  GetAnalyticsUsecase(this.repository);

  Future<AnalyticsData> execute() async {
    final reviews = await repository.getReviews('Todo');

    if (reviews.isEmpty) {
      return AnalyticsData.empty();
    }

    final currentYear = DateTime.now().year;

    // 1. Total Reviews This Year
    int totalReviewsThisYear = 0;
    int totalReviewsLastYear = 0;

    // 2. Reviews Per Month
    // Initialize map for all 12 months with 0
    Map<int, int> reviewsPerMonth = {for (var i = 1; i <= 12; i++) i: 0};

    // 3. Top Genres
    Map<String, int> genreCounts = {};

    // 4. Top Formats
    Map<String, int> formatCounts = {};

    // 5. Top Platforms
    Map<String, int> platformCounts = {};

    for (var review in reviews) {
      // Activity
      if (review.updateAt.year == currentYear) {
        totalReviewsThisYear++;
        reviewsPerMonth[review.updateAt.month] =
            (reviewsPerMonth[review.updateAt.month] ?? 0) + 1;
      } else if (review.updateAt.year == currentYear - 1) {
        totalReviewsLastYear++;
      }

      // Genres
      final genre = review.genre.isNotEmpty ? review.genre : 'Unknown';
      genreCounts[genre] = (genreCounts[genre] ?? 0) + 1;

      // Formats
      String format = review.contentType.toString().split('.').last;
      formatCounts[format] = (formatCounts[format] ?? 0) + 1;

      // Platforms
      final platform = review.platform.isNotEmpty ? review.platform : 'Unknown';
      platformCounts[platform] = (platformCounts[platform] ?? 0) + 1;
    }

    // Calculate percentage increase
    double percentageIncrease = 0.0;
    if (totalReviewsLastYear > 0) {
      percentageIncrease =
          ((totalReviewsThisYear - totalReviewsLastYear) /
              totalReviewsLastYear) *
          100;
    } else if (totalReviewsThisYear > 0) {
      percentageIncrease = 100.0; // From 0 to something is 100% technically
    }

    // Helper to get top items from a map
    Map<String, int> getTop(Map<String, int> map, {int count = 3}) {
      var entries =
          map.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
      return Map.fromEntries(entries.take(count));
    }

    // Helper to get top items as List<MapEntry>
    List<MapEntry<String, int>> getTopList(
      Map<String, int> map, {
      int count = 3,
    }) {
      var entries =
          map.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
      return entries.take(count).toList();
    }

    return AnalyticsData(
      totalReviewsThisYear: totalReviewsThisYear,
      percentageIncrease: double.parse(percentageIncrease.toStringAsFixed(1)),
      reviewsPerMonth: reviewsPerMonth,
      topGenres: getTop(genreCounts),
      topFormats: getTop(formatCounts),
      topPlatforms: getTopList(platformCounts),
    );
  }
}
