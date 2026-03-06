import 'package:critijoy_note/features/reviews/presentation/views/analytics_view.dart';
import 'package:critijoy_note/features/reviews/presentation/views/home_view.dart';
import 'package:critijoy_note/features/reviews/presentation/views/add_review_view.dart';
import 'package:critijoy_note/features/reviews/presentation/views/edit_review_view.dart';
import 'package:critijoy_note/features/reviews/presentation/views/review_details_view.dart';
import 'package:critijoy_note/features/splash/presentation/views/splash_view.dart';
import 'package:critijoy_note/features/reviews/presentation/views/genres_view.dart';
import 'package:critijoy_note/features/reviews/domain/models/review.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final approuter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => SplashScreen()),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    GoRoute(
      path: '/editreview',
      builder: (context, state) {
        final review = state.extra as Review?;
        return EditReview(review: review);
      },
    ),
    GoRoute(path: '/addreview', builder: (context, state) => AddReview()),
    GoRoute(path: '/geners', builder: (context, state) => GenersScreen()),
    GoRoute(
      path: '/reviewdetails',
      builder: (context, state) {
        final review = state.extra as Review;
        return ReviewDetailsView(typeContenido: review);
      },
    ),
    GoRoute(path: '/analytics', builder: (context, state) => AnalyticsView()),
  ],
);
