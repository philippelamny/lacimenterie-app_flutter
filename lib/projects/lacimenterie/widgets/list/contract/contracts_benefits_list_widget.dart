import 'package:flutter/material.dart';
import 'package:lacimenterie/projects/lacimenterie/api/contract/contract_api_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/pages/contract/contract_detail_page_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/list/list_widget_abstract.dart';

class ContractsBenefitsListWidget extends ListWidgetAbstract {
  ContractsBenefitsListWidget(List list) : super(list);

  @override
  bool isWithSubtitle() {
    return true;
  }

  String getLabelFinishedPhases(item) {
    int nbOver = 0;
    String lastInvoicedPhase;
    String firstInvoicedPhase;
    for (var phase in item['phases']) {
      if (phase['totalInvoiced'] == phase['total']){
        //beneficeProjet = beneficeProjet + phase.totalRemaining;
        if(firstInvoicedPhase == null) { //Je cherche la première facturée à 100%
            firstInvoicedPhase= phase['name'];
        }
        lastInvoicedPhase = phase['name']; //Je cherche la dernière facturée à 100% //->sous réserve qu'elles arrivent dans l'ordre depuis le service, ce qui n'est pas le cas //->Exclure les "missions complémentaires"
        nbOver++;  
      }
    }
    String label = '';
    switch (nbOver) {
      case 0:
        label = 'Aucune phase terminée';
        break;
      default:
        label = nbOver.toString() + ' phase(s) terminée(s) ' + (lastInvoicedPhase == null ? '': '(' + lastInvoicedPhase + ')');
        break;
    }

    return label;
  }

  Column buildItemTileSubtitle(context, item) {
    String label = this.getLabelFinishedPhases(item);

    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Text(
                label,
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                item['totalInvoicedRemaining'].round().toString() + ' €',
                textAlign: TextAlign.right,
                style: TextStyle(color: (item['totalInvoicedRemaining'] >= 0 ? Colors.green : Colors.red) ),
              ),
            )
          ],
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  String getItemTileLeadingPhotoDefault(context, item) => ContractApiLacimenterie.getDefaultImageContract();

  String getItemTileLeadingPhoto(context, item) {
    return item['photo'];
  } 

  String getItemTileTitle(context, item) {
      return item['name'];
  }
  
  List<Widget> buildList(context) {
    final List<Widget> listRow = [];
    int total = 0;
    
    for (final contract in this.list) {
      total += contract['totalInvoicedRemaining'].round();
      listRow.add(buildItemContainer(context, contract));
    }

    listRow.insert(0,
      Text(
        'Bénéfice sur les projets en cours ' + total.toString() + ' €',
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
      )
    );
    

    return listRow;
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
