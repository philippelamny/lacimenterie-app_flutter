import 'dart:convert';
import 'package:lacimenterie/projects/lacimenterie/api/api_lacimenterie_abstract.dart';

class AuthApiLacimenterie extends ApiLacimenterieAbstract {
  
  Future<String> connectAction(String name, String password) async {
    var data = { '_username' : name, '_password' : password };
    var response = await this.post('login_check', body: data);
    var values = jsonDecode(response.body);
    String token = "";
    if (values['result']) {
      token = values['token'];
    }
    return token;
  }

  Future<dynamic> getGeneralInfoAction() async {
    var response = await this.get('site/agency/general-infos');
    return jsonDecode(response.body);
  }

}