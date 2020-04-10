import 'package:flutter/material.dart';
import 'package:lacimenterie/bundles/widgets/loader/waiting_screen_loader_widget.dart';
import 'package:lacimenterie/projects/lacimenterie/api/contract/contract_api_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/services/auth_service_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/app_bar_widget_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/header/agence_padding_header_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    if (this._generalInfo == null || this._contactInfo == null) {
      return WaitingScreenLoaderWidget();
    }

    this._contactInfo = null;
    return Scaffold(
      appBar: AppBarWidgetLacimenterie(widget.auth, widget.logoutCallback),
      body: IconTheme.merge(
        data: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        child: ListView(
          children: <Widget>[
            AgencePaddingHeaderWidget(this._generalInfo['photo'], this._generalInfo['agencyName'], this._generalInfo['userName']),
            Text('page projetinfo')
          ],
        ),
      ),
    );
  }
}
