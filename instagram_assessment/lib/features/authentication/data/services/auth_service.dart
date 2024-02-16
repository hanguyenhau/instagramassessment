import 'package:instagram_assessment/features/authentication/data/models/auth_result.dart';
import 'package:instagram_assessment/features/authentication/data/repository/auth_repository_impl.dart';

class AuthService {
  final AuthRepositoryImpl _authRepository;

  AuthService(this._authRepository);

  Future<AuthResult> loginWithGoogle() async{
    return _authRepository.loginWithGoogle();
  }

  Future<void> signOut() async {
    return _authRepository.signOut();
  }
}