import 'package:lacimenterie/bundles/authenticate/models/user_model_abstract.dart';

/// 
class UserModelLacimenterie implements UserModelAbstract {

  String _id;
  ///result: true
  ///agencyName: "lacimenterie archi A"
  ///userName: "PHILIPPE LAM"
  ///photo: "http:/
  var _generalInfos;

  UserModelLacimenterie(String id, var generalInfos) {
    this._id = id;
    this._generalInfos = generalInfos;
  }

  dynamic getGeneralInfos() {
    return this._generalInfos;
  }

  @override
  String getId() {
    return this._id;
  }
}