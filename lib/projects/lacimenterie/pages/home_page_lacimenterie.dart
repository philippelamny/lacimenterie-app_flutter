import 'package:flutter/material.dart';
import 'package:lacimenterie/bundles/authenticate/services/auth_service_abstract.dart';
import 'package:lacimenterie/bundles/widgets/loader/waiting_screen_loader_widget.dart';
import 'package:lacimenterie/projects/lacimenterie/api/contract/contract_api_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/models/user_model_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/services/auth_service_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/app_bar_widget_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/header/agence_padding_header_widget.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/list/contract/contracts_benefits_list_widget.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/list/contract/contracts_ca_facture_list_widget.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/list/contract/contracts_ca_signe_list_widget.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/list/contract/contracts_phases_list_widget.dart';
import 'package:provider/provider.dart';

class HomePageLacimenterie extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageLacimenterieState();
}

class _HomePageLacimenterieState extends State<HomePageLacimenterie> {
  dynamic _generalInfo;
  List _byContractPhase;
  List _contractBenifits;
  List _contractCAFacture;
  List _contractCASigne;
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _widgetOptions;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthServiceAbstract auth = Provider.of<AuthServiceLacimenterie>(context);
    if (this._generalInfo == null) {
      UserModelLacimenterie user = auth.getCurrentUser();
      setState(() {
        if (user != null) {
          this._generalInfo = user.getGeneralInfos();
        }
      });
    }

    if (this._byContractPhase == null) {
      ContractApiLacimenterie api = new ContractApiLacimenterie();
      api.analyseAction().then((dynamic analysis) {
        setState(() {
          this._byContractPhase = analysis['byContractPhase']['infosBar'];
          this._contractBenifits = analysis['benefits']['infosBar'];
          this._contractCAFacture = analysis['ca']['invoices'];
          this._contractCASigne = analysis['ca']['contracts'];
        });
      });
    }

    if (this._generalInfo == null 
      || this._byContractPhase == null
      || this._contractBenifits == null
      || this._contractCAFacture == null
      || this._contractCASigne == null
      ) {
      return WaitingScreenLoaderWidget();
    }

    if (this._widgetOptions == null) {
      this._widgetOptions = <Widget>[
        ContractsPhasesListWidget(this._byContractPhase),
        ContractsBenefitsListWidget(this._contractBenifits),
        ContractsCAFactureListWidget(this._contractCAFacture),
        ContractsCASigneListWidget(this._contractCASigne)
      ];
    }

    return Scaffold(
      appBar: AppBarWidgetLacimenterie(context),
      body: IconTheme.merge(
        data: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        child: ListView(
          children: <Widget>[
            AgencePaddingHeaderWidget(this._generalInfo['photo'],
                this._generalInfo['agencyName'], this._generalInfo['userName']),
            _widgetOptions.elementAt(_selectedIndex),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.equalizer),
            title: Text('Temps restant'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Bénéfice'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            title: Text('CA facturé'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            title: Text('CA signé'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
