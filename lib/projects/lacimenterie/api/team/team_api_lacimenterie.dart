import 'dart:convert';
import 'package:lacimenterie/projects/lacimenterie/api/api_lacimenterie_abstract.dart';

class TeamApiLacimenterie extends ApiLacimenterieAbstract {
  
  Future<dynamic> getTeamListAction() async {
    var data = {};
    var response = await this.post('site/member/list', body: data);
    var values = jsonDecode(response.body);
    
    return values;
  }

}