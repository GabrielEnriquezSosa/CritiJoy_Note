import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:critijoy_note/core/database/database.dart';
import 'package:critijoy_note/features/auth/domain/user.dart';
import 'package:critijoy_note/features/auth/repositories/auth_repository.dart';
import 'package:critijoy_note/features/reviews/domain/models/review.dart';
import 'package:drift/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

/// Key used to persist the logged-in user's id across app restarts.
const _kSessionUserIdKey = 'session_user_id';

class AuthRepositoryImpl implements AuthRepository {
  final AppDatabase _db;
  User? _cachedUser;

  AuthRepositoryImpl(this._db);

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  // ─── Persist / clear session ───────────────────────────────────────────────

  Future<void> _persistSession(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kSessionUserIdKey, userId);
  }

  Future<void> _clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kSessionUserIdKey);
  }

  // ─── Public API ────────────────────────────────────────────────────────────

  @override
  Future<User> signUp(String name, String email, String password) async {
    final existing =
        await (_db.select(_db.users)
          ..where((t) => t.email.equals(email))).getSingleOrNull();

    if (existing != null) {
      throw Exception('Ya existe una cuenta con este correo electrónico.');
    }

    final userId = const Uuid().v4();
    final hashedPassword = _hashPassword(password);

    await _db
        .into(_db.users)
        .insert(
          UsersCompanion(
            id: Value(userId),
            name: Value(name),
            email: Value(email),
            passwordHash: Value(hashedPassword),
            profilePicturePath: const Value(''),
            createdAt: Value(DateTime.now()),
            syncStatus: const Value(1),
          ),
        );

    final user = User(id: userId, name: name, email: email, photoUrl: '');
    _cachedUser = user;
    await _persistSession(userId);
    return user;
  }

  @override
  Future<User> signIn(String email, String password) async {
    final hashedPassword = _hashPassword(password);

    final entry =
        await (_db.select(_db.users)
          ..where((t) => t.email.equals(email))).getSingleOrNull();

    if (entry == null) {
      throw Exception('No se encontró una cuenta con este correo.');
    }

    if (entry.passwordHash != hashedPassword) {
      throw Exception('Contraseña incorrecta.');
    }

    final user = User(
      id: entry.id,
      name: entry.name,
      email: entry.email,
      photoUrl: entry.profilePicturePath ?? '',
    );

    _cachedUser = user;
    await _persistSession(user.id);
    return user;
  }

  @override
  Future<void> signOut() async {
    _cachedUser = null;
    await _clearSession();
  }

  @override
  Future<User?> getCurrentUser() async {
    return _cachedUser;
  }

  /// Tries to restore a previously saved session from SharedPreferences.
  /// Returns the [User] if a valid session exists, otherwise null.
  @override
  Future<User?> restoreSession() async {
    final prefs = await SharedPreferences.getInstance();
    final storedId = prefs.getString(_kSessionUserIdKey);
    if (storedId == null) return null;

    final entry =
        await (_db.select(_db.users)
          ..where((t) => t.id.equals(storedId))).getSingleOrNull();

    if (entry == null) {
      // Stored id no longer exists in DB – clear stale data.
      await _clearSession();
      return null;
    }

    final user = User(
      id: entry.id,
      name: entry.name,
      email: entry.email,
      photoUrl: entry.profilePicturePath ?? '',
    );

    _cachedUser = user;
    return user;
  }

  @override
  Future<void> changePassword(
    String userId,
    String currentPassword,
    String newPassword,
  ) async {
    final entry =
        await (_db.select(_db.users)
          ..where((t) => t.id.equals(userId))).getSingleOrNull();

    if (entry == null) throw Exception('Usuario no encontrado.');

    final currentHash = _hashPassword(currentPassword);
    if (entry.passwordHash != currentHash) {
      throw Exception('La contraseña actual es incorrecta.');
    }

    if (newPassword.trim().length < 6) {
      throw Exception('La nueva contraseña debe tener al menos 6 caracteres.');
    }

    final newHash = _hashPassword(newPassword);
    await (_db.update(_db.users)..where(
      (t) => t.id.equals(userId),
    )).write(UsersCompanion(passwordHash: Value(newHash)));
  }

  @override
  Future<User> updateProfile(User user) async {
    await (_db.update(_db.users)..where((t) => t.id.equals(user.id))).write(
      UsersCompanion(
        name: Value(user.name),
        email: Value(user.email),
        profilePicturePath: Value(user.photoUrl),
        syncStatus: const Value(2),
      ),
    );

    _cachedUser = user;
    return user;
  }

  @override
  Future<void> syncReviewsToCloud(List<Review> reviews) async {
    // Placeholder for future cloud integration.
  }
}
