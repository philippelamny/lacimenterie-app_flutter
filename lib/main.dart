import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:lacimenterie/bundles/root/pages/root_page.dart';
import 'package:lacimenterie/projects/lacimenterie/services/auth_service_lacimenterie.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthServiceLacimenterie(),
      child: MyApp(),
    )
  );
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GlobalConfiguration().loadFromAsset("app_settings");

    // Faire un truc générique en fonction du service AuthSerce à utliser
    // ==> Factory ??
    //AuthServiceAbstract auth = new AuthServiceLacimenterie();

    return MaterialApp(
      title: 'Lacimenterie',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: RootPage(),
    );
  }
}