import 'package:flutter/material.dart';
import 'package:lacimenterie/bundles/authenticate/class/enum/auth_status_enum.dart';
import 'package:lacimenterie/bundles/authenticate/pages/login_signup_page.dart';
import 'package:lacimenterie/bundles/root/pages/home_page.dart';
import 'package:lacimenterie/bundles/widgets/loader/waiting_screen_loader_widget.dart';
import 'package:lacimenterie/projects/lacimenterie/services/auth_service_lacimenterie.dart';
import 'package:provider/provider.dart';

class RootPage extends StatefulWidget {
  

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthServiceLacimenterie auth; 
  
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  Widget build(BuildContext context) {
    this.auth = Provider.of<AuthServiceLacimenterie>(context);
    var user = this.auth.getCurrentUser();
  
    if (user != null) {
      _userId = user.getId();
    }
    var authStatus = _userId == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
    
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return WaitingScreenLoaderWidget();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginSignupPage();
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new HomePage();
        } else
          return WaitingScreenLoaderWidget();
        break;
      default:
        return WaitingScreenLoaderWidget();
    }
  }
}