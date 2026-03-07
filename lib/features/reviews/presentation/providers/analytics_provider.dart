import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/analytics_data.dart';
import '../../domain/usecases/get_analytics_usecase.dart';
import 'review_repository_provider.dart';
import 'reviews_provider.dart';

// Provides the GetAnalyticsUsecase
final getAnalyticsUseCaseProvider = Provider<GetAnalyticsUsecase>((ref) {
  final repository = ref.watch(reviewRepositoryProvider);
  return GetAnalyticsUsecase(repository);
});

// Provides the computed AnalyticsData. We watch reviewsProvider to refresh analytics whenever a review is added/deleted/updated.
final analyticsProvider = FutureProvider<AnalyticsData>((ref) async {
  // Watch the reviews to trigger a rebuild when they change
  ref.watch(reviewsProvider);

  final useCase = ref.watch(getAnalyticsUseCaseProvider);
  return await useCase.execute();
});
