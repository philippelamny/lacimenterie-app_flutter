import 'package:flutter/material.dart';
import 'package:lacimenterie/projects/lacimenterie/services/auth_service_lacimenterie.dart';
import 'package:cached_network_image/cached_network_image.dart';


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
                        child:  CachedNetworkImage(
                          placeholder: (context, url) => CircularProgressIndicator(),
                          imageUrl: this._generalInfo['photo'],
                           //Image.network(this._generalInfo['photo'],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              this._generalInfo['agencyName']
                              , style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              )
                            ),
                            Text(this._generalInfo['userName']),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
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
