// A widget that displays the picture taken by the user.
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:crop/crop.dart';
import 'package:lacimenterie/bundles/widgets/rectangular/centered_slider_track_shape_rectangular_widget.dart';

class DisplayPictureScreenCameraWidget extends StatefulWidget {
  final String imagePath;
  const DisplayPictureScreenCameraWidget({Key key, this.imagePath}) : super(key: key);

  @override
  DisplayPictureScreenCameraWidgetState  createState() => DisplayPictureScreenCameraWidgetState();
    
}

class DisplayPictureScreenCameraWidgetState extends State<DisplayPictureScreenCameraWidget>  {
  
 
  //     child: Image.file(File(widget.imagePath)) //Image.asset('images/sample.jpg'),
  

      final controller = CropController(aspectRatio: 1000 / 667.0);
  double _rotation = 0;
  void _cropImage() async {
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final cropped = await controller.crop(pixelRatio: pixelRatio);

    /*Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('Votre photo final'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.add_to_photos),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          
          body: Center(
            child: RawImage(
              image: cropped,
            ),
          ),
        ),
        fullscreenDialog: true,
      ),
    );*/
    // Ajouter l'image au projet
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: _cropImage,
            tooltip: 'Ajouter la photo au projet',
            icon: Icon(Icons.add_to_photos),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.black,
              padding: EdgeInsets.all(8),
              child: Crop(
                controller: controller,
                child: Image.file(File(widget.imagePath), fit: BoxFit.cover,),
                foreground: IgnorePointer(
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'lacimenterie.archi',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                helper: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.undo),
                tooltip: 'Annuler',
                onPressed: () {
                  controller.rotation = 0;
                  controller.scale = 1;
                  controller.offset = Offset.zero;
                  setState(() {
                    _rotation = 0;
                  });
                },
              ),
              Expanded(
                child: SliderTheme(
                  data: theme.sliderTheme.copyWith(
                    trackShape: CenteredSliderTrackShapeRectangularWidget(),
                  ),
                  child: Slider(
                    divisions: 361,
                    value: _rotation,
                    min: -180,
                    max: 180,
                    label: '$_rotation°',
                    onChanged: (n) {
                      setState(() {
                        _rotation = n.roundToDouble();
                        controller.rotation = _rotation;
                      });
                    },
                  ),
                ),
              ),
              PopupMenuButton<double>(
                icon: Icon(Icons.aspect_ratio),
                itemBuilder: (context) => [
                  /*PopupMenuItem(
                    child: Text("Original"),
                    value: 1000 / 667.0,
                  ),*/
                  PopupMenuDivider(),
                  PopupMenuItem(
                    child: Text("16:9"),
                    value: 16.0 / 9.0,
                  ),
                  /*PopupMenuItem(
                    child: Text("4:3"),
                    value: 4.0 / 3.0,
                  ),
                  PopupMenuItem(
                    child: Text("1:1"),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text("3:4"),
                    value: 3.0 / 4.0,
                  ),
                  PopupMenuItem(
                    child: Text("9:16"),
                    value: 9.0 / 16.0,
                  ),*/
                ],
                tooltip: 'Aspect Ratio',
                onSelected: (x) {
                  controller.aspectRatio = x;
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}