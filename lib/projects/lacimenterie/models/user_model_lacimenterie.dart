import 'package:lacimenterie/bundles/authenticate/models/user_model_abstract.dart';

/// 
class UserModelLacimenterie implements UserModelAbstract {

  String _id;
  var _generalInfos;

  UserModelLacimenterie(String id, var generalInfos) {
    this._id = id;
    this._generalInfos = generalInfos;
  }

  void getGeneralInfos() {
    return this._generalInfos;
  }

  @override
  String getId() {
    return this._id;
  }
}