import 'package:flutter/material.dart';
import 'package:lacimenterie/projects/lacimenterie/api/contract/contract_api_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/api/team/team_api_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/list/list_widget_abstract.dart';

class TeamListWidget extends ListWidgetAbstract {
  TeamListWidget(List list) : super(list);

  @override
  Column buildItemTileSubtitle(context, item) {
    return Column(
      children: [
        Text(
          item['email'],
          textAlign: TextAlign.left,
        ),
        Column(
          children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap
                  ,value: true, onChanged: (bool value) {},
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  'Compte actif',
                  textAlign: TextAlign.left,
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap
                  //checkColor: Color.,
                  ,value: true, onChanged: (bool value) {},
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  'Admin',
                  textAlign: TextAlign.left,
                ),
              )
            ],
          )
        ])
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  @override
  bool isWithSubtitle() => true;

  @override
  void onTapFunction(context, item) {
    // TODO: implement onTapFunction
  }

  @override
  String getItemTileTitle(context, item) {
    return item['firstname'] + ' ' + item['lastname'];
  }

  @override
  String getItemTileLeadingPhoto(context, item) => null;

  @override
  String getItemTileLeadingPhotoDefault(context, item) =>
      TeamApiLacimenterie.getDefaultAvatarArchi();
}
