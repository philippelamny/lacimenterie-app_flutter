
import 'dart:async';
import 'package:lacimenterie/bundles/authenticate/models/user_model_abstract.dart';
import 'package:lacimenterie/bundles/authenticate/services/auth_service_abstract.dart';
import 'package:lacimenterie/projects/lacimenterie/models/user_model_lacimenterie.dart';


class AuthServiceLacimenterie implements AuthServiceAbstract {
  //final RequestLacimenterie _auth: new RequestLacimenterie();

  Future<String> signIn(String email, String password) async {
    
    return "";
  }

  Future<String> signUp(String email, String password) async {
    
    return "";
  }

  Future<UserModelAbstract> getCurrentUser() async {
    UserModelLacimenterie user = new UserModelLacimenterie();
    return user;
  }

  Future<void> signOut() async {
    
  }

  Future<void> sendEmailVerification() async {
    
  }

  Future<bool> isEmailVerified() async {
    return true;
  }
}