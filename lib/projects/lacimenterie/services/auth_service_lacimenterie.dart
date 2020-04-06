
import 'dart:async';
import 'package:lacimenterie/bundles/authenticate/models/user_model_abstract.dart';
import 'package:lacimenterie/bundles/authenticate/services/auth_service_abstract.dart';
import 'package:lacimenterie/projects/lacimenterie/api/auth/auth_api_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/models/user_model_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/services/request_service_lacimenterie.dart';


class AuthServiceLacimenterie implements AuthServiceAbstract {
   UserModelLacimenterie _user;
  

  bool isConnected() {
    return false;
  }

  Future<String> signIn(String email, String password) async {
    AuthApiLacimenterie api = new AuthApiLacimenterie();
    String token = await api.connectAction(email, password);
    if (token != '') {
      RequestServiceLacimenterie.updateToken(token);
      var generalInfos = api.getGeneralInfoAction();
      this._user = new UserModelLacimenterie(token, generalInfos);
    }
    
    return token;
  }

  Future<String> signUp(String email, String password) async {

    return "";
  }

  Future<UserModelAbstract> getCurrentUser() async {
    if (this._user == null) this._user = new UserModelLacimenterie(null, {});
    return this._user;
  }

  Future<void> signOut() async {
    
  }

  Future<void> sendEmailVerification() async {
    
  }

  Future<bool> isEmailVerified() async {
    return true;
  }
}