import 'dart:convert';
import 'package:lacimenterie/projects/lacimenterie/api/api_lacimenterie_abstract.dart';

class ContractApiLacimenterie extends ApiLacimenterieAbstract {
  
  static String getDefaultImageContract() {
    return ApiLacimenterieAbstract.getPathForUrlRelative('/assets/img/camera.png');
  }

  Future<dynamic> analyseAction() async {
    var response = await this.get('site/agency/analysis');
    return jsonDecode(response.body);
  }

}