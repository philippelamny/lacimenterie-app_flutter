import 'package:flutter/material.dart';
import 'package:lacimenterie/projects/lacimenterie/models/user_model_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/services/auth_service_lacimenterie.dart';



class HomePageLacimenterie extends StatefulWidget{
  HomePageLacimenterie({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final AuthServiceLacimenterie auth;
  final VoidCallback logoutCallback;
  final String userId;
 
  @override
  State<StatefulWidget> createState() => new _HomePageLacimenterieState();
    
}


class _HomePageLacimenterieState extends State<HomePageLacimenterie> {
  dynamic _generalInfo;

  @override
  void initState()  {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          this._generalInfo = user.getGeneralInfos();
        }
      });
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this._generalInfo == null) {
      return this.buildWaitingScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Lacimenterie | Dashboard'),
        actions: <Widget>[
          PopupMenuButton<int>(
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
      ),
      body: IconTheme.merge(
        data: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(Icons.create, size: 72.0),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              this._generalInfo != null ? this._generalInfo['agencyName'] : ''
                              , style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              )
                            ),
                            Text('Virtuell, 00 virtuell, VR'),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('08:30 - 12:30 Uhr'),
                          Text(''),
                          Text(''),
                        ],
                      ),
                    ],
                  ),
                  Divider(height: 1.0),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: DashboardButton(
                      icon: Icons.person,
                      text: 'Profil',
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: DashboardButton(
                      icon: Icons.person,
                      text: 'Blackboard',
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: DashboardButton(
                      icon: Icons.person,
                      text: 'Campus-Nachrichten',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: DashboardButton(
                      icon: Icons.person,
                      text: 'Veranstaltungen',
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: DashboardButton(
                      icon: Icons.person,
                      text: 'Termine',
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: DashboardButton(
                      icon: Icons.person,
                      text: 'Prufengen',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: DashboardButton(
                      icon: Icons.person,
                      text: 'Ansprechpartner',
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: DashboardButton(
                      icon: Icons.person,
                      text: 'Modulportal',
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: DashboardButton(
                      icon: Icons.book,
                      text: 'Literaturrecherche',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardButton extends StatelessWidget {
  const DashboardButton({
    Key key,
    @required this.icon,
    @required this.text,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FractionallySizedBox(
              widthFactor: 0.6,
              child: FittedBox(
                child: Icon(icon),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textScaleFactor: 0.8,
            ),
            SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(height: 1.0),
            ),
          ],
        ),
      ),
    );
  }
}
