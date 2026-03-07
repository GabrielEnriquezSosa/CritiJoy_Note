import 'package:critijoy_note/features/auth/repositories/auth_repository.dart';
import 'package:critijoy_note/features/auth/domain/user.dart';

class SignInUsecase {
  final AuthRepository repository;

  SignInUsecase(this.repository);

  Future<User> execute(String email, String password) {
    return repository.signIn(email, password);
  }
}
