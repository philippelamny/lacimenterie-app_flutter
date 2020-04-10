import 'package:flutter/material.dart';
import 'package:lacimenterie/projects/lacimenterie/services/auth_service_lacimenterie.dart';

class AppBarWidgetLacimenterie extends AppBar {
  @override
  AppBarWidgetLacimenterie(AuthServiceLacimenterie auth, VoidCallback logoutCallback, {Key key})
      : super(
        key: key
        ,title: Text('Lacimenterie')
        ,actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (value) {
              switch (value) {
                case 0:
                  logoutCallback();
                  break;
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<int>>[
                PopupMenuItem(
                  value: 0,
                  child: Text('Déconnexion'),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Text('Dashboard'),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text('FAQ'),
                ),
              ];
            },
          ),
        ],
      );
}