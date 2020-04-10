import 'package:flutter/material.dart';
import 'package:lacimenterie/projects/lacimenterie/api/contract/contract_api_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/services/auth_service_lacimenterie.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ContractDetailPageLacimenterie extends StatefulWidget {
  ContractDetailPageLacimenterie({Key key, this.auth, this.userId, this.logoutCallback, this.contractId})
      : super(key: key);

  final AuthServiceLacimenterie auth;
  final VoidCallback logoutCallback;
  final int contractId;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _ContractDetailPageLacimenterieState();
}

class _ContractDetailPageLacimenterieState extends State<ContractDetailPageLacimenterie> {
  dynamic _generalInfo;
  dynamic _contactInfo;

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          this._generalInfo = user.getGeneralInfos();
        }
      });
    });
    ContractApiLacimenterie api = new ContractApiLacimenterie();
    api.getInfoSummaryAction(widget.contractId).then((dynamic contactInfo) {
      setState(() {
        this._contactInfo = contactInfo;
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

  Widget buildHeader() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(17, 5, 38, 5),
                  child: CachedNetworkImage(
                    height: 50,
                    fit: BoxFit.scaleDown,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: this._generalInfo['photo'],
                  ),
                ),
                Expanded(
                  child: Column(
                    
                    children: <Widget>[
                      Text(this._generalInfo['agencyName'],
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      Text(this._generalInfo['userName'],
                          textAlign: TextAlign.left),
                    ],
                  ),
                ),
              ],
            ),
            Divider(height: 1.0),
          ],
        ),
      );

  Widget buildAppBar() => AppBar(
        title: Text('Lacimenterie | Dashboard'),
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (value) {
              switch (value) {
                case 0:
                  widget.logoutCallback();
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

  @override
  Widget build(BuildContext context) {
    if (this._generalInfo == null || this._contactInfo == null) {
      return this.buildWaitingScreen();
    }
this._contactInfo = null;
    return Scaffold(
      appBar: this.buildAppBar(),
      body: IconTheme.merge(
        data: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        child: ListView(
          children: <Widget>[
            this.buildHeader(),
            Text('page projetinfo')
          ],
        ),
      ),
    );
  }
}
