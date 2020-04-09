import 'dart:convert';
import 'dart:io';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:lacimenterie/projects/lacimenterie/services/request_service_lacimenterie.dart';

abstract class ApiLacimenterieAbstract {
  
  static String getPathForUrlRelative(String urlRelative) {
    return GlobalConfiguration().getString('api-url') + '/' + urlRelative;
  }

  static String getApiPath() {
    return GlobalConfiguration().getString('api-url') + '/api/';
  }

  Future<Response> post(url, {Map<String, String> headers, body, Encoding encoding, fullUrl: false}) async {
    String urlToPost = url;
    if (fullUrl == false) {
      urlToPost = ApiLacimenterieAbstract.getApiPath() + urlToPost;
    }

    var headers = RequestServiceLacimenterie.getInstance().headers;
    headers[HttpHeaders.contentTypeHeader] = "application/x-www-form-urlencoded";
    headers[HttpHeaders.authorizationHeader] = RequestServiceLacimenterie.getInstance().getToken();
    
    var response = await http.post(urlToPost, body: body, headers: headers);
    RequestServiceLacimenterie.updateCookie(response);
    return response;
  }


  Future<Response> get(url, {Map<String, String> headers, fullUrl: false}) async {
    String urlToPost = url;
    if (fullUrl == false) {
      urlToPost = ApiLacimenterieAbstract.getApiPath() + urlToPost;
    }
    var headers = RequestServiceLacimenterie.getInstance().headers;
    headers[HttpHeaders.contentTypeHeader] = "application/x-www-form-urlencoded";
    headers[HttpHeaders.authorizationHeader] = RequestServiceLacimenterie.getInstance().getToken();

    var response = await http.get(urlToPost, headers: headers);
    return response;
  }
}
