import 'dart:convert';
import 'package:lacimenterie/projects/lacimenterie/api/api_lacimenterie_abstract.dart';

class ContractApiLacimenterie extends ApiLacimenterieAbstract {
  
  static String getDefaultImageContract() {
    return ApiLacimenterieAbstract.getPathForUrlRelative('/assets/img/camera.png');
  }

  Future<dynamic> checkAction() async {
    var response = await this.get('site/contract/check');
    return jsonDecode(response.body);
  }

  Future<dynamic> selectAction(contractId) async {
    var response = await this.get('site/contract/select?idContract=' + contractId.toString());
    return jsonDecode(response.body);
  }

  Future<dynamic> analyseAction() async {
    var response = await this.get('site/agency/analysis');
    return jsonDecode(response.body);
  }

  Future<dynamic> checkSelectAction(contractId) async {
    var response = await this.checkAction();
    if (response['idContract'] != contractId) {
      response = await this.selectAction(contractId);
    }
    return response;
  }

  Future<dynamic> getInfoSummaryAction(int contractId, {bool withSelect : true}) async {
    if (withSelect) {
      await this.checkSelectAction(contractId);
    }

    var response = await this.get('site/info-summary/get');
    var values = jsonDecode(response.body);
    return values;
  }

}