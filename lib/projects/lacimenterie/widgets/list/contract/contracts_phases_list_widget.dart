import 'package:flutter/material.dart';
import 'package:lacimenterie/bundles/tools/math/math_tools.dart';
import 'package:lacimenterie/projects/lacimenterie/api/contract/contract_api_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/pages/contract/contract_detail_page_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/list/list_widget_abstract.dart';

class ContractsPhasesListWidget extends ListWidgetAbstract {
  ContractsPhasesListWidget(List list) : super(list);

  @override
  bool isWithSubtitle() {
    return true;
  }

  Column buildItemTileSubtitle(context, item) {
    final List<Widget> listRow = [];
    for (final subitem in item['phases']) {
      listRow.add(Column(children: [
        Row(children: [
          Expanded(
            flex: 4,
            child: Text(
              subitem['phaseName'],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              subitem['daysRemainingEq'].round().toString() + ' j.',
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
                      value: MathTools.calcPourcentage(subitem['total'],
                          subitem['totalRemaining']), // infoBarPhase
                      valueColor: AlwaysStoppedAnimation(
                          subitem['totalRemaining'] >= 0
                              ? Colors.green
                              : Colors.red)),
                )),
            Expanded(
              flex: 5,
              child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    subitem['totalRemaining'].round().toString() +
                        '€ / ' +
                        subitem['total'].round().toString() + '€',
                    textAlign: TextAlign.right,
                  )),
            )
          ],
        )
      ]));
    }

    return Column(children: listRow);
  }

  String getItemTileLeadingPhotoDefault(context, item) => ContractApiLacimenterie.getDefaultImageContract();

  String getItemTileLeadingPhoto(context, item) => item['photo'];

  String getItemTileTitle(context, item) {
      return item['projectName'];
  }
  
  void onTapFunction(context, item) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContractDetailPageLacimenterie(
                  contractId: item['idContract'],
                )));
  }
}
