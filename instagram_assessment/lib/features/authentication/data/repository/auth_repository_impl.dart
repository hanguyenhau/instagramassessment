import 'package:instagram_assessment/features/authentication/data/data_sources/firebase/auth_firebase.dart';
import 'package:instagram_assessment/features/authentication/data/models/auth_result.dart';
import 'package:instagram_assessment/features/authentication/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository<AuthResult> {
  final FirebaseAuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource) : super();

@override
  Future<AuthResult> loginWithGoogle() async{
    return _authDataSource.loginWithGoogle();
  }

  @override
  Future<void> signOut() async {
    return _authDataSource.signOut();
  }
  
}
