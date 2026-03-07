import 'package:critijoy_note/features/auth/repositories/auth_repository.dart';
import 'package:critijoy_note/features/auth/domain/user.dart';

class GetCurrentUserUsecase {
  final AuthRepository repository;

  GetCurrentUserUsecase(this.repository);

  Future<User?> execute() {
    return repository.getCurrentUser();
  }
}
