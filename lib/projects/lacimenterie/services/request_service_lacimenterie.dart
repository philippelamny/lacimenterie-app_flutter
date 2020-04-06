import 'package:http/http.dart' as http;

class RequestServiceLacimenterie {
  
  

  static RequestServiceLacimenterie _instance;

  String _token;
  Map<String, String> headers = {"content-type": "text/json"};
  Map<String, String> cookies = {};

  /// Singleton 
  static RequestServiceLacimenterie getInstance() {
    if (_instance == null) {
      _instance = new RequestServiceLacimenterie();
    }

    return _instance;
  }

  static RequestServiceLacimenterie updateCookie(http.Response response) {
    RequestServiceLacimenterie instance = RequestServiceLacimenterie.getInstance();
    instance._updateCookie(response);

    return instance;
  }

  static RequestServiceLacimenterie updateToken(String token) {
    RequestServiceLacimenterie instance = RequestServiceLacimenterie.getInstance();
    instance._token = token;
    return instance;
  } 

  String getToken() {
    return this._token;
  }
  
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
        if (key == 'path' || key == 'expires') return;

        this.cookies[key] = value;
      }
    }
  }

  String _generateCookieHeader() {
    String cookie = "";

    for (var key in cookies.keys) {
      if (cookie.length > 0) cookie += ";";
      cookie += key + "=" + cookies[key];
    }

    return cookie;
  }

}
