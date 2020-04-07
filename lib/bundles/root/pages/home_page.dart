import 'package:flutter/material.dart';
import 'package:lacimenterie/bundles/authenticate/services/auth_service_abstract.dart';
import 'package:lacimenterie/projects/lacimenterie/pages/home_page_lacimenterie.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final AuthServiceAbstract auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return new HomePageLacimenterie(
            userId: widget.userId,
            auth: widget.auth,
            logoutCallback: widget.logoutCallback,
          );
  }
}