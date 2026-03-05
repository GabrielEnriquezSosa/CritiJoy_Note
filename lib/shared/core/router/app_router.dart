import 'package:critijoy_note/features/reviews/presentation/views/home_view.dart';
import 'package:critijoy_note/features/reviews/presentation/views/add_review_view.dart';
import 'package:critijoy_note/features/reviews/presentation/views/edit_review_view.dart';
import 'package:critijoy_note/features/splash/presentation/views/splash_view.dart';
import 'package:critijoy_note/features/genres/presentation/views/genres_view.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final approuter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => SplashScreen()),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/editreview', builder: (context, state) => EditReview()),
    GoRoute(path: '/addreview', builder: (context, state) => AddReview()),
    GoRoute(path: '/geners', builder: (context, state) => GenersScreen()),
  ],
);
