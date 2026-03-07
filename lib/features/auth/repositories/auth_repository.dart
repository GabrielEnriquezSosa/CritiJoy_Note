import 'package:critijoy_note/features/auth/domain/user.dart';
import 'package:critijoy_note/features/reviews/domain/models/review.dart';

/// Abstract contract for authentication operations.
abstract class AuthRepository {
  Future<User> signUp(String name, String email, String password);
  Future<User> signIn(String email, String password);
  Future<void> signOut();
  Future<User?> getCurrentUser();

  /// Restores a previously persisted session (e.g. from SharedPreferences).
  /// Returns the [User] if a valid session exists, null otherwise.
  Future<User?> restoreSession();

  /// Changes the user's password, verifying the current one first.
  Future<void> changePassword(
    String userId,
    String currentPassword,
    String newPassword,
  );

  /// Updates the user's profile data (name, email, profilePicturePath).
  Future<User> updateProfile(User user);

  /// Pushes local reviews to the cloud database for the authenticated user.
  Future<void> syncReviewsToCloud(List<Review> reviews);
}
