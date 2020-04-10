import 'package:flutter/material.dart';
import 'package:lacimenterie/bundles/authenticate/class/enum/auth_status_enum.dart';
import 'package:lacimenterie/bundles/authenticate/pages/login_signup_page.dart';
import 'package:lacimenterie/bundles/authenticate/services/auth_service_abstract.dart';
import 'package:lacimenterie/bundles/root/pages/home_page.dart';
import 'package:lacimenterie/bundles/widgets/loader/waiting_screen_loader_widget.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final AuthServiceAbstract auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user.getId();
        }
        authStatus =
            _userId == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.getId();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return WaitingScreenLoaderWidget();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginSignupPage(
          auth: widget.auth,
          loginCallback: loginCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new HomePage(
            userId: _userId,
            auth: widget.auth,
            logoutCallback: logoutCallback,
          );
        } else
          return WaitingScreenLoaderWidget();
        break;
      default:
        return WaitingScreenLoaderWidget();
    }
  }
}