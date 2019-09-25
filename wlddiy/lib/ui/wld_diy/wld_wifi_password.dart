import 'package:flutter/material.dart';
import 'package:wlddiy/model/network.dart';

class WldWifiPassword extends StatefulWidget {
  final Network network;
  WldWifiPassword(this.network);

  _WldWifiPasswordState createState() => _WldWifiPasswordState();
}

class _WldWifiPasswordState extends State<WldWifiPassword> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff3a93ff),
              Colors.blue,
              Color(0xff3a93ff),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                height: height * 0.15,
                child: Center(
                  child: Text('Password '.toUpperCase(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22)),
                ),
              ),
              Container(
                  height: height * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.network.sSID,
                          style:
                              TextStyle(fontSize: 18.0, color: Colors.black45)),
                      SizedBox(height: 15),
                      TextField(
                          controller: myController,
                          style: TextStyle(color: Colors.white60, fontSize: 24),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter Wifi Password',
                              hintStyle: TextStyle(
                                  color: Colors.white60, fontSize: 24),
                              labelStyle: TextStyle(
                                  color: Colors.white60, fontSize: 24)))
                    ],
                  )),
              Container(
                height: height * 0.1,
                color: Colors.amberAccent,
                child: RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.blue,
                    color: Colors.white,
                    onPressed: () => _navigateNext(context),
                    child: Text(
                      'Next',
                      style: TextStyle(fontSize: 20),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0))),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _navigateNext(BuildContext context) {
    
  }
}
