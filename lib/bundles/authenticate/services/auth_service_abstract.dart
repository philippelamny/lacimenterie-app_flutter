import 'package:lacimenterie/bundles/authenticate/models/user_model_abstract.dart';

abstract class AuthServiceAbstract {
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  UserModelAbstract getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}
