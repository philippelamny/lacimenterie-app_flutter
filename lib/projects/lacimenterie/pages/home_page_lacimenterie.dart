import 'package:flutter/material.dart';
import 'package:lacimenterie/bundles/tools/math/math_tools.dart';
import 'package:lacimenterie/projects/lacimenterie/api/contract/contract_api_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/services/auth_service_lacimenterie.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePageLacimenterie extends StatefulWidget {
  HomePageLacimenterie({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final AuthServiceLacimenterie auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageLacimenterieState();
}

class _HomePageLacimenterieState extends State<HomePageLacimenterie>  {
  dynamic _generalInfo;
  List _byContractPhase;

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
    api.analyseAction().then((dynamic analysis) {
      setState(() {
        this._byContractPhase = analysis['byContractPhase']['infosBar'];
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

  List<Widget> makeListPhases(phases) {
    final List<Widget> listRow = [];
    for (final phase in phases) {
      listRow.add(Column(children: [
        Row(children: [
          Expanded(
            flex: 4,
            child: Text(
              phase['phaseName'],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              phase['daysRemainingEq'].round().toString() + ' j.',
              textAlign: TextAlign.right,
            ),
          )
        ]),
        Row(
          children: <Widget>[
            Expanded(
                flex: 5,
                child: Container(
                  // tag: 'hero',
                  child: LinearProgressIndicator(
                      backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                      value: MathTools.calcPourcentage(phase['total'], phase['totalRemaining']), // infoBarPhase
                      valueColor: AlwaysStoppedAnimation(phase['totalRemaining'] >= 0 ? Colors.green : Colors.red)),
                )),
            Expanded(
              flex: 5,
              child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(phase['totalRemaining'].toString() +
                        ' / ' +
                        phase['total'].toString(),
                        textAlign: TextAlign.right,
                  )),
            )
          ],
        )
      ]));
    }

    return listRow;
  }

  ListTile makeListTile(infoBarPhase) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: CachedNetworkImage(
            placeholder: (context, url) => CachedNetworkImage(
              fit: BoxFit.scaleDown,
              width: 60,
              imageUrl: ContractApiLacimenterie.getDefaultImageContract(),
            ),
            fit: BoxFit.scaleDown,
            width: 60,
            imageUrl: infoBarPhase['photo'] != null
                ? infoBarPhase['photo']
                : ContractApiLacimenterie.getDefaultImageContract(),
          ),
        ),
        title: Text(
          infoBarPhase['projectName'],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(children: this.makeListPhases(infoBarPhase['phases'])) ,
        /*trailing:
        Icon(Icons.keyboard_arrow_right, size: 30.0),*/
    /*onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(infoBarPhase: infoBarPhase)));
      },*/
      );

  Card makeCard(contractByPhase) => Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          child: makeListTile(contractByPhase),
        ),
      );

  Widget buildListContracts() {
    if (this._byContractPhase == null) {
      return this.buildWaitingScreen();
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: this._byContractPhase.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(this._byContractPhase[index]);
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    if (this._generalInfo == null || this._byContractPhase == null) {
      return this.buildWaitingScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Lacimenterie | Dashboard'),
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (value) {
              switch(value) {
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
      ),
      body: IconTheme.merge(
        data: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(17, 5, 38, 5),
                        child: CachedNetworkImage(
                          height: 50,
                          fit: BoxFit.scaleDown,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          imageUrl: this._generalInfo['photo'],
                          //Image.network(this._generalInfo['photo'],
                        ),
                      ),
                      Expanded(
                        
                        child: Column(
                          
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(this._generalInfo['agencyName'],
                            textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(this._generalInfo['userName'], textAlign:TextAlign.left), 
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 1.0),
                ],
              ),
            ),
            this.buildListContracts()
          ],
        ),
      ),
    );
  }
}
