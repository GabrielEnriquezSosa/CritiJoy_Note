import 'package:critijoy_note/features/auth/repositories/auth_repository.dart';

class SignOutUsecase {
  final AuthRepository repository;

  SignOutUsecase(this.repository);

  Future<void> execute() {
    return repository.signOut();
  }
}
