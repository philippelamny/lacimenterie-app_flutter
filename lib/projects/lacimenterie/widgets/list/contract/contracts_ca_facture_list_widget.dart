import 'package:flutter/material.dart';
import 'package:lacimenterie/projects/lacimenterie/api/contract/contract_api_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/pages/contract/contract_detail_page_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/list/list_widget_abstract.dart';

class ContractsCAFactureListWidget extends ListWidgetAbstract {
  ContractsCAFactureListWidget(List list) : super(list);

  @override
  bool isWithSubtitle() {
    return true;
  }

  String getLabelFinishedPhases(item) {
    
    String label = '';
    if (item['historics'].length > 0) {
      label = item['historics'].last['date'] ?? '-';
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
                item['totalExclTax'].round().toString() + ' €',
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.green),
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
      total += contract['totalExclTax'].round();
      listRow.add(buildItemContainer(context, contract));
    }

    listRow.insert(0,
      Text(
        'CA Facturé ' + total.toString() + ' €',
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
