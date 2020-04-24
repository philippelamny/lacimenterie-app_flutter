
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:lacimenterie/bundles/widgets/camera/take_picture_screen_camera_widget.dart';
import 'package:lacimenterie/bundles/widgets/loader/waiting_screen_loader_widget.dart';
import 'package:lacimenterie/projects/lacimenterie/services/auth_service_lacimenterie.dart';
import 'package:provider/provider.dart';

class ContractPhotoPageLacimenterie extends StatefulWidget {
  ContractPhotoPageLacimenterie({Key key, this.contractId})
      : super(key: key);

  final int contractId;

  @override
  State<StatefulWidget> createState() => new _ContractPhotoPageLacimenterieState();
}

class _ContractPhotoPageLacimenterieState extends State<ContractPhotoPageLacimenterie> {
  AuthServiceLacimenterie auth;
  dynamic _firstCamera;
  
  void initState () {
    super.initState();
    this.initCameraToTakePicture().then((firstCamera)  {
      setState(() {
        this._firstCamera = firstCamera;
      });
    });
  }


  Future <CameraDescription> initCameraToTakePicture()  async{
    WidgetsFlutterBinding.ensureInitialized();
      final cameras = await availableCameras();
      return cameras.first;
  }

  @override
  Widget build(BuildContext context) {
    this.auth = Provider.of<AuthServiceLacimenterie>(context);
  
    if (this._firstCamera == null) {
      return WaitingScreenLoaderWidget();
    }
    return TakePictureScreenCameraWidget(camera: this._firstCamera,);
  }
}
