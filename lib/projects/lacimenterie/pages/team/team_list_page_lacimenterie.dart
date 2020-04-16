import 'package:flutter/material.dart';
import 'package:lacimenterie/bundles/widgets/loader/waiting_screen_loader_widget.dart';
import 'package:lacimenterie/projects/lacimenterie/api/team/team_api_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/models/user_model_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/services/auth_service_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/app_bar_widget_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/header/agence_padding_header_widget.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/list/team/team_list_widget.dart';
import 'package:provider/provider.dart';

class TeamListPageLacimenterie extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() => new _TeamListPageLacimenterieState();
}

class _TeamListPageLacimenterieState extends State<TeamListPageLacimenterie> {
  AuthServiceLacimenterie auth;
  dynamic _generalInfo;
  dynamic _teamsList;

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
    
    if (this._teamsList == null) {
      TeamApiLacimenterie api = new TeamApiLacimenterie();
      api.getTeamListAction().then((dynamic teams) {
        setState(() {
          this._teamsList = teams['items'];
        });
      });
    }
    
    if (this._generalInfo == null || this._teamsList == null) {
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
            TeamListWidget(this._teamsList)
          ],
        ),
      ),
    );
  }
}
