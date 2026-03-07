import 'package:critijoy_note/core/database/database_provider.dart';
import 'package:critijoy_note/features/auth/data/auth_repository_impl.dart';
import 'package:critijoy_note/features/auth/domain/user.dart';
import 'package:critijoy_note/features/auth/repositories/auth_repository.dart';
import 'package:critijoy_note/features/auth/usecases/get_current_user_usecase.dart';
import 'package:critijoy_note/features/auth/usecases/sign_in.dart';
import 'package:critijoy_note/features/auth/usecases/sign_out.dart';
import 'package:critijoy_note/features/auth/usecases/sign_up_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides the concrete AuthRepository instance backed by Drift.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return AuthRepositoryImpl(db);
});

/// Use case providers
final signInUsecaseProvider = Provider<SignInUsecase>((ref) {
  return SignInUsecase(ref.watch(authRepositoryProvider));
});

final signUpUsecaseProvider = Provider<SignUpUsecase>((ref) {
  return SignUpUsecase(ref.watch(authRepositoryProvider));
});

final signOutUsecaseProvider = Provider<SignOutUsecase>((ref) {
  return SignOutUsecase(ref.watch(authRepositoryProvider));
});

final getCurrentUserUsecaseProvider = Provider<GetCurrentUserUsecase>((ref) {
  return GetCurrentUserUsecase(ref.watch(authRepositoryProvider));
});

/// Manages the currently authenticated user state.
class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier() : super(null);

  void setUser(User user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }
}

final authStateProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier();
});
