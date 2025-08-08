import 'package:critijoy_note/presentation/screen/screen.dart';
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
