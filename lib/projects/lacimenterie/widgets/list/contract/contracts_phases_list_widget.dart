import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lacimenterie/bundles/tools/math/math_tools.dart';
import 'package:lacimenterie/projects/lacimenterie/api/contract/contract_api_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/pages/contract/contract_detail_page.dart';
import 'package:lacimenterie/projects/lacimenterie/services/auth_service_lacimenterie.dart';

class ContractsPhasesListWidget extends StatelessWidget {

  final List contractsPhases;
  final AuthServiceLacimenterie auth;
  final VoidCallback logoutCallback;
  final String userId;
  

  const ContractsPhasesListWidget({Key key, this.contractsPhases, this.auth, this.userId, this.logoutCallback}) : super(key: key);


  List<Widget> makeListPhases(context, phases) {
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
                      value: MathTools.calcPourcentage(phase['total'],
                          phase['totalRemaining']), // infoBarPhase
                      valueColor: AlwaysStoppedAnimation(
                          phase['totalRemaining'] >= 0
                              ? Colors.green
                              : Colors.red)),
                )),
            Expanded(
              flex: 5,
              child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    phase['totalRemaining'].toString() +
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

  ListTile makeListTile(context, infoBarPhase) => ListTile(
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
        subtitle: Column(children: this.makeListPhases(context, infoBarPhase['phases'])),
        //trailing:
        //Icon(Icons.keyboard_arrow_right, size: 30.0),
        onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ContractDetailPageLacimenterie(auth: this.auth, userId: this.userId, logoutCallback : this.logoutCallback, contractId: infoBarPhase['idContract'],)));
        },
      );

  Card makeCard(context, contractByPhase) => Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          child: makeListTile(context, contractByPhase),
        ),
      );

  List<Widget> buildListContracts(context) {
    final List<Widget> listRow = [];
    for (final contract in this.contractsPhases) {
      listRow.add(makeCard(context, contract));
    }
    return listRow;
  }

  @override
  Widget build(BuildContext context) {
    
    return Column(children : this.buildListContracts(context));
  }

}