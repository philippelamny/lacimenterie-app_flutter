import 'package:flutter/material.dart';
import 'package:lacimenterie/projects/lacimenterie/pages/team/team_list_page_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/services/auth_service_lacimenterie.dart';
import 'package:provider/provider.dart';

class AppBarWidgetLacimenterie extends AppBar {

  @override
  AppBarWidgetLacimenterie(BuildContext context,{Key key})
      : super(
          key: key,
          title: Text('Lacimenterie'),
          actions: <Widget>[
            PopupMenuButton<int>(
              onSelected: (value) {
                AuthServiceLacimenterie auth = Provider.of<AuthServiceLacimenterie>(context);
                
                switch (value) {
                  case 0:
                    auth.signOut();
                    break;
                  case 1:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TeamListPageLacimenterie()));
                }
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) {
                int index = 0;
                return <PopupMenuEntry<int>>[
                  PopupMenuItem(
                    value: index++,
                    child: Text('Déconnexion'),
                  ),
                  PopupMenuItem(
                    value: index++,
                    child: Text('Team'),
                  ),
                  PopupMenuItem(
                    value: index++,
                    child: Text('Dashboard'),
                  ),
                  PopupMenuItem(
                    value: index++,
                    child: Text('FAQ'),
                  ),
                ];
              },
            ),
          ],
        );
}
