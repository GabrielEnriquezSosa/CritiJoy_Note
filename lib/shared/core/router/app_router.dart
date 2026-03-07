import 'package:critijoy_note/features/reviews/presentation/views/analytics_view.dart';
import 'package:critijoy_note/features/reviews/presentation/views/config_view.dart';
import 'package:critijoy_note/features/reviews/presentation/views/home_view.dart';
import 'package:critijoy_note/features/reviews/presentation/views/add_review_view.dart';
import 'package:critijoy_note/features/reviews/presentation/views/edit_review_view.dart';
import 'package:critijoy_note/features/reviews/presentation/views/review_details_view.dart';
import 'package:critijoy_note/features/splash/presentation/views/splash_view.dart';
import 'package:critijoy_note/features/reviews/presentation/views/genres_view.dart';
import 'package:critijoy_note/features/reviews/presentation/views/authors_view.dart';
import 'package:critijoy_note/features/auth/presentation/views/sign_in_view.dart';
import 'package:critijoy_note/features/auth/presentation/views/sign_up_view.dart';
import 'package:critijoy_note/features/auth/presentation/views/edit_profile_view.dart';
import 'package:critijoy_note/features/reviews/presentation/views/about_view.dart';
import 'package:critijoy_note/features/reviews/domain/models/review.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final approuter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => SplashScreen()),
    GoRoute(path: '/signin', builder: (context, state) => const SignInView()),
    GoRoute(path: '/signup', builder: (context, state) => const SignUpView()),
    GoRoute(
      path: '/editprofile',
      builder: (context, state) => const EditProfileView(),
    ),
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
    GoRoute(path: '/autores', builder: (context, state) => AuthorsView()),
    GoRoute(
      path: '/reviewdetails',
      builder: (context, state) {
        final review = state.extra as Review;
        return ReviewDetailsView(typeContenido: review);
      },
    ),
    GoRoute(path: '/analytics', builder: (context, state) => AnalyticsView()),
    GoRoute(path: '/config', builder: (context, state) => ConfigView()),
    GoRoute(path: '/about', builder: (context, state) => const AboutView()),
  ],
);
