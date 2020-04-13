import 'package:flutter/material.dart';
import 'package:lacimenterie/bundles/widgets/loader/waiting_screen_loader_widget.dart';
import 'package:lacimenterie/projects/lacimenterie/api/contract/contract_api_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/models/user_model_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/services/auth_service_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/app_bar_widget_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/header/agence_padding_header_widget.dart';
import 'package:provider/provider.dart';

class ContractDetailPageLacimenterie extends StatefulWidget {
  ContractDetailPageLacimenterie({Key key, this.contractId})
      : super(key: key);

  final int contractId;

  @override
  State<StatefulWidget> createState() => new _ContractDetailPageLacimenterieState();
}

class _ContractDetailPageLacimenterieState extends State<ContractDetailPageLacimenterie> {
  AuthServiceLacimenterie auth;
  dynamic _generalInfo;
  dynamic _contactInfo;

  @override
  Widget build(BuildContext context) {
    
    this.auth = Provider.of<AuthServiceLacimenterie>(context);
    if (this._generalInfo == null) {
      UserModelLacimenterie user = this.auth.getCurrentUser();
      setState(() {
        if (user != null) {
          this._generalInfo = user.getGeneralInfos();
        }
      });
    }
    
    if (this._contactInfo == null) {
      ContractApiLacimenterie api = new ContractApiLacimenterie();
      api.getInfoSummaryAction(widget.contractId).then((dynamic contactInfo) {
        setState(() {
          this._contactInfo = contactInfo;
        });
      });
    }
    
    if (this._generalInfo == null || this._contactInfo == null) {
      return WaitingScreenLoaderWidget();
    }

    return Scaffold(
      appBar: AppBarWidgetLacimenterie(context),
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