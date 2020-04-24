
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:lacimenterie/bundles/widgets/chart/circular_indicator_chart_widget.dart';
import 'package:lacimenterie/bundles/widgets/loader/waiting_screen_loader_widget.dart';
import 'package:lacimenterie/projects/lacimenterie/api/contract/contract_api_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/models/user_model_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/services/auth_service_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/app_bar_widget_lacimenterie.dart';
import 'package:lacimenterie/projects/lacimenterie/widgets/contract/cached_network_image_contract_lacimenterie.dart';
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
  dynamic _contractInfo;
  dynamic _firstCamera;
  File _image;

  void initState () {
    super.initState();
    this.initCameraToTakePicture().then((firstCamera)  {
      setState(() {
        this._firstCamera = firstCamera;
      });
    });
  }

  Future getImage() async {
    var image;
    
  }

  Padding getRowTitleValue(String title, String value) {
    return Padding(
    padding: EdgeInsets.all(5.0),
    child: Row(    
        children: [
          Expanded(
            flex: 1,
            child: Text(title),
          ),
          Expanded(
            flex: 2,
            child: Text(value ?? '-'),
          ),
        ]
      ),
    );
    
  }

  /// TODO : Generaliser dans un tool
  Future <CameraDescription> initCameraToTakePicture()  async{
    WidgetsFlutterBinding.ensureInitialized();
      final cameras = await availableCameras();
      return cameras.first;
  }

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
    
    if (this._contractInfo == null) {
      ContractApiLacimenterie api = new ContractApiLacimenterie();
      api.getInfoSummaryAction(widget.contractId).then((dynamic contractInfo) {
        setState(() {
          this._contractInfo = contractInfo;
        });
      });
    }
    
    if (this._generalInfo == null || this._contractInfo == null) {
      return WaitingScreenLoaderWidget();
    }

    Color remainingValue = this._contractInfo['contractAnalysis']['totalRemaining'] >= 0 ? Colors.green : Colors.red;

    return Scaffold(
      appBar: AppBarWidgetLacimenterie(context),
      floatingActionButton: FloatingActionButton(

        child: Icon(Icons.camera_alt),

        onPressed: () async {
          try {
          
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
      body: IconTheme.merge(
        data: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        child: ListView(
          children: <Widget>[
            AgencePaddingHeaderWidget(this._generalInfo['photo'], this._generalInfo['agencyName'], this._generalInfo['userName']),
            Text(
              this._contractInfo['name']['value'] ?? '-'
              , textAlign: TextAlign.center
              , style: TextStyle(color: Colors.blueAccent, fontSize: 20.0)
            ),
            Text(
              this._contractInfo['city']['value'] ?? '-'
              , textAlign: TextAlign.center
              , style: TextStyle(color: Colors.blueAccent, fontSize: 15.0)
            ),
            Container(
              height: 180,
              child: CachedNetworkImageContractLacimenterie(this._contractInfo['photo'], fit: BoxFit.fitWidth),
            ),
            
            Center(
              child: 
              Row(
                children: [ 
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Column(children: [
                        Text(
                          "HONORAIRES", 
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "CONSOMMÉS",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Divider(color: Colors.black,),
                        Text(
                          this._contractInfo['contractAnalysis']['totalHonoraryConsumed'].round().toString() + "€ ht",
                          style: TextStyle(
                            color: Color.fromRGBO(221, 221, 221, 1),
                            fontWeight: FontWeight.bold
                          )
                        ),
                        Text("équivalent à " + this._contractInfo['contractAnalysis']['daysEqConsumed'].toStringAsFixed(1) + " j."),
                      ],)
                    )
                  ),
                  Expanded(
                    flex: 1,
                    child: CustomPaint(
                      foregroundPainter: CircularIndicatorChartWidget(
                        this._contractInfo['contractAnalysis']['pcentConsumed'].round().toDouble(),
                        colorCompleteArc: remainingValue
                      ),
                      child: Container(child: Center(
                        child: Text(
                          (
                            this._contractInfo['contractAnalysis']['pcentConsumed'].round() <= 100 
                            ? this._contractInfo['contractAnalysis']['pcentConsumed'].round().toString()
                            : "100"
                          )
                          + " %"
                        )
                      ), width: 120, height: 120),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Column(children: [
                        Text(
                          "HONORAIRES",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "RESTANTS",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Divider(color: Colors.black,),
                        Text(
                          this._contractInfo['contractAnalysis']['totalRemaining'].round().toString() + "€ ht",
                          style: TextStyle(
                            color: remainingValue,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text("équivalent à " + this._contractInfo['contractAnalysis']['daysEqRemaining'].toStringAsFixed(1) + " j."),
                      ],)
                    )
                  ),
                ]
              )
            ),
            Center(child: Text(
              this._contractInfo['contractAnalysis']['totalHonoraryConsumed'].round().toString() 
              + " € sur "
              + (this._contractInfo['contractAnalysis']['totalHonoraryConsumed'] + this._contractInfo['contractAnalysis']['totalRemaining']).round().toString() 
              + " €"
            )),
            Divider(
              color: Colors.black,
            ),
            this.getRowTitleValue("Maître d'ouvrage : ",  this._contractInfo['moa']['fullName']),
            this.getRowTitleValue("Pôle : ",  this._contractInfo['pole']['name']),
            this.getRowTitleValue("Programme : ",  this._contractInfo['program']['name']),
            this.getRowTitleValue("Montant travaux : ",  this._contractInfo['amount_work']['value'] != null ? this._contractInfo['amount_work']['value'].toString() + ' €': '-'),
            this.getRowTitleValue("Surface :	",  this._contractInfo['area']['value'] != null ? this._contractInfo['area']['value'].toString() + ' m²': '-'),
          ],
        ),
      ),
    );
  }
}
