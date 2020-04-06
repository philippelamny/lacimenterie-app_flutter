import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  
  String token = '';

  Map<String, String> headers = {"content-type": "text/json"};
  Map<String, String> cookies = {};

void _updateCookie(http.Response response) {
    String allSetCookie = response.headers['set-cookie'];

    if (allSetCookie != null) {

      var setCookies = allSetCookie.split(',');

      for (var setCookie in setCookies) {
        var cookies = setCookie.split(';');

        for (var cookie in cookies) {
          _setCookie(cookie);
        }
      }

      headers['cookie'] = _generateCookieHeader();
    }
  }

  void _setCookie(String rawCookie) {
    if (rawCookie.length > 0) {
      var keyValue = rawCookie.split('=');
      if (keyValue.length == 2) {
        var key = keyValue[0].trim();
        var value = keyValue[1];

        // ignore keys that aren't cookies
        if (key == 'path' || key == 'expires')
          return;

        this.cookies[key] = value;
      }
    }
  }

  String _generateCookieHeader() {
    String cookie = "";

    for (var key in cookies.keys) {
      if (cookie.length > 0)
        cookie += ";";
      cookie += key + "=" + cookies[key];
    }

    return cookie;
  }

  bool connected() {
    return false;
  }

  Future<bool> connectAction(String name, String password) async {
    print('Connect with ' + name + ' -- ' + password );
    String url = GlobalConfiguration().getString('api-url') + '/api/login_check';
    var data = { '_username' : name, '_password' : password };
    var response = await http.post(url, body: data);
    var values = jsonDecode(response.body);
    token = values['token'];
    print('Response status: ${response.statusCode}');
    _updateCookie(response);

    headers[HttpHeaders.contentTypeHeader] = "application/x-www-form-urlencoded";
    headers[HttpHeaders.authorizationHeader] = token;
    response = await http.get('http://demo.lacimenterie.archi/api/site/agency/general-infos', headers: headers);
    print('Response status: ${response.body}');

    response = await http.get('http://demo.lacimenterie.archi/api/site/timetracking/week/index', headers: headers);
    print('Response status: ${response.body}');
    
    return false;
  }
}