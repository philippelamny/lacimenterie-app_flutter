import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/list/list_widget_interface.dart';

abstract class ListWidgetAbstract extends StatelessWidget implements ListWidgetInterface {
  final List list;
  const ListWidgetAbstract(this.list, {Key key, }) : super(key: key);

  Text buildItemTileTitle(context, item) {
    return Text(
      this.getItemTileTitle(context, item),
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Container buildItemTileLeading(context, item) {
    return Container(
      padding: EdgeInsets.only(right: 12.0),
      decoration: new BoxDecoration(
          border: new Border(
              right: new BorderSide(width: 1.0, color: Colors.white24))),
      child: CachedNetworkImage(
        placeholder: (context, url) => CachedNetworkImage(
          fit: BoxFit.scaleDown,
          width: 60,
          imageUrl: getItemTileLeadingPhotoDefault(context, item),
        ),
        fit: BoxFit.scaleDown,
        width: 60,
        imageUrl: ( getItemTileLeadingPhoto(context, item) != null && getItemTileLeadingPhoto(context, item) != "" ? getItemTileLeadingPhoto(context, item) : getItemTileLeadingPhotoDefault(context, item)),
      ),
    );
  }

  ListTile buildItemTile(context, item) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: buildItemTileLeading(context, item),
      title: buildItemTileTitle(context, item),
      subtitle: isWithSubtitle() ? this.buildItemTileSubtitle(context, item) : null,
      //trailing:
      //Icon(Icons.keyboard_arrow_right, size: 30.0),
      onTap: () {this.onTapFunction(context, item);},
    );
  }

  Card buildItemContainer(context, item) => Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          child: buildItemTile(context, item),
        ),
      );

  List<Widget> buildList(context) {
    final List<Widget> listRow = [];
    for (final contract in this.list) {
      listRow.add(buildItemContainer(context, contract));
    }
    return listRow;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children : this.buildList(context));
  }

}