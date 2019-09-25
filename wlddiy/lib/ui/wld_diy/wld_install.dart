import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wlddiy/delayed_animation.dart';
import 'package:wlddiy/page_route.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:wlddiy/ui/wld_diy/wld_location.dart';

class WldInstall extends StatefulWidget {
  @override
  _WldInstallState createState() => _WldInstallState();
}

class _WldInstallState extends State<WldInstall>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;
  bool _connectBtnTapped = false;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;

    var height = MediaQuery.of(context).size.height;
    return Material(
        type: MaterialType.transparency,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xCC3a93ff),
                Color(0xff3a93ff),
              ],
            ),
          ),
          child: Column(children: <Widget>[
            Container(
                height: height * 0.15,
                child: DelayedAimation(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text('Water leak detector'.toUpperCase(),
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color(0xFFF9F9FB), fontSize: 24)),
                    ),
                  ),
                  delay: delayedAmount + 500,
                )),
            Container(
              height: height * 0.7,
              child: getBodyWidget(),
            ),
            Container(
                height: height * 0.15,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(30),
                child: DelayedAimation(
                  delay: delayedAmount + 4000,
                  child: RaisedButton(
                      padding: const EdgeInsets.all(8.0),
                      textColor: Colors.blue,
                      color: Colors.white,
                      onPressed: () {
                        _navigateNext(context);
                      },
                      child: Text(
                        _connectBtnTapped
                            ? 'Searching for devices...'
                            : 'Connect',
                        style: TextStyle(fontSize: 20),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                )),
          ]),
        ));
  }

  Widget getBodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
         
          DelayedAimation(
            child: Align(
              alignment: Alignment.center,
              child: Text('Power up your water leak detector',
                  style: TextStyle(color: Color(0xFFF9F9FB), fontSize: 20)),
            ),
            delay: delayedAmount + 1000,
          ),
          DelayedAimation(
            child: Text(
                'Install batteries in your Water Leak and Freeze Detector. You\'ll see the detector\'s LED pulse blue as it pairs with the app.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xB3F9F9FB), fontSize: 18)),
            delay: delayedAmount + 2000,
          ),
          SizedBox(height: 20,),
          DelayedAimation(
            delay: delayedAmount + 3000,
            child: Container(
              alignment: Alignment.center,
              height: 200,
              width: 200,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  blurRadius: 43.0,
                  color: Colors.black.withOpacity(.5),
                  offset: Offset(6.0, 7.0),
                ),
              ], color: Colors.transparent),
              child: Image.asset(
                'assets/images/wld_power_up_illustration.png',
              ),
            ),
          ),
          Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: FlareActor("assets/linear_load.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.fitHeight,
                  animation: "Untitled"))
        ],
      ),
    );
  }

  void _navigateNext(BuildContext context) {
    // if (_connectBtnTapped) {
    setState(() {
      _connectBtnTapped = true;
    });
    Timer(Duration(seconds: 10), () {
      Navigator.push(context, SlideTopRoute(page: WldLocationName()));
    });
  }
}
