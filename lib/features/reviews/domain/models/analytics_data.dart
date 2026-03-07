class AnalyticsData {
  final int totalReviewsThisYear;
  final double percentageIncrease;
  final Map<int, int> reviewsPerMonth;
  final Map<String, int> topGenres;
  final Map<String, int> topFormats;
  final List<MapEntry<String, int>> topPlatforms;

  AnalyticsData({
    required this.totalReviewsThisYear,
    required this.percentageIncrease,
    required this.reviewsPerMonth,
    required this.topGenres,
    required this.topFormats,
    required this.topPlatforms,
  });

  factory AnalyticsData.empty() {
    return AnalyticsData(
      totalReviewsThisYear: 0,
      percentageIncrease: 0.0,
      reviewsPerMonth: {},
      topGenres: {},
      topFormats: {},
      topPlatforms: [],
    );
  }
}
