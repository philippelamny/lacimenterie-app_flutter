import 'package:flutter/material.dart';
import 'package:lacimenterie/projects/lacimenterie/pages/home_page_lacimenterie.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  @override
  Widget build(BuildContext context) {
    return new HomePageLacimenterie();
  }
}