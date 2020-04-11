import 'package:flutter/material.dart';
import 'package:lacimenterie/bundles/widgets/loader/waiting_screen_loader_widget.dart';
import 'package:lacimenterie/projects/lacimenterie/api/contract/contract_api_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/models/user_model_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/services/auth_service_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/app_bar_widget_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/header/agence_padding_header_widget.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/list/contract/contracts_phases_list_widget.dart';

class HomePageLacimenterie extends StatefulWidget {
  HomePageLacimenterie({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final AuthServiceLacimenterie auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageLacimenterieState();
}

class _HomePageLacimenterieState extends State<HomePageLacimenterie> {
  dynamic _generalInfo;
  List _byContractPhase;

  @override
  void initState() {
    super.initState();
    UserModelLacimenterie user = widget.auth.getCurrentUser();
    setState(() {
      if (user != null) {
        this._generalInfo = user.getGeneralInfos();
      }
    });
    
    ContractApiLacimenterie api = new ContractApiLacimenterie();
    api.analyseAction().then((dynamic analysis) {
      setState(() {
        this._byContractPhase = analysis['byContractPhase']['infosBar'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (this._generalInfo == null || this._byContractPhase == null) {
      return WaitingScreenLoaderWidget();
    }
    
    return Scaffold(
      appBar: AppBarWidgetLacimenterie(widget.auth, widget.logoutCallback),
      body: IconTheme.merge(
        data: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        child: ListView(
          children: <Widget>[
            AgencePaddingHeaderWidget(this._generalInfo['photo'], this._generalInfo['agencyName'], this._generalInfo['userName']),
            ContractsPhasesListWidget(contractsPhases: this._byContractPhase, auth: widget.auth, userId: widget.userId, logoutCallback : widget.logoutCallback,)
          ],
        ),
      ),
    );
  }
}
