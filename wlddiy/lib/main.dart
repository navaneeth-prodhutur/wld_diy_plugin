import 'package:flutter/material.dart';
import 'package:wlddiy/model/network.dart';
import 'package:wlddiy/ui/wld_diy/wld_install.dart';
import 'package:wlddiy/ui/wld_diy/wld_wifi_password.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WldInstall(),
    );
  }
}
