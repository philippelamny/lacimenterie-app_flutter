import 'package:lacimenterie/bundles/authenticate/models/user_model_abstract.dart';

/// 
class UserModelLacimenterie implements UserModelAbstract {

  String _id;

  userModelLacimenterie({id: ''}) {
    this._id = id;
  }

  @override
  String getId() {
    return this._id;
  }
}