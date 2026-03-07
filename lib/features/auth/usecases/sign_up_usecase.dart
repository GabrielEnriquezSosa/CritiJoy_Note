import 'package:critijoy_note/features/auth/repositories/auth_repository.dart';
import 'package:critijoy_note/features/auth/domain/user.dart';

class SignUpUsecase {
  final AuthRepository repository;

  SignUpUsecase(this.repository);

  Future<User> execute(String name, String email, String password) {
    return repository.signUp(name, email, password);
  }
}
