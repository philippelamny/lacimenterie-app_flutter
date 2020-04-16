import 'package:flutter/material.dart';

abstract class ListWidgetInterface {
  String getItemTileTitle(context, item);
  String getItemTileLeadingPhotoDefault(context, item);
  String getItemTileLeadingPhoto(context, item);
  Container buildItemTileLeading(context, item);
  Text buildItemTileTitle(context, item);
  Column buildItemTileSubtitle(context, item);
  bool isWithSubtitle();
  void onTapFunction(context, item);
  ListTile buildItemTile(context, item);
  Card buildItemContainer(context, item);
  List<Widget> buildList(context);
  
}