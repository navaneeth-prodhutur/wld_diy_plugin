import 'package:flutter/material.dart';
import 'package:wlddiy/model/network.dart';
import 'package:wlddiy/page_route.dart';
import 'package:wlddiy/ui/wld_diy/discovery_wifi_item.dart';
import 'package:wlddiy/ui/wld_diy/wld_wifi_password.dart';

class DiscoveryHomeWifi extends StatefulWidget {
  const DiscoveryHomeWifi({Key key}) : super(key: key);
  @override
  _DiscoveryHomeWifiState createState() => _DiscoveryHomeWifiState();
}

class _DiscoveryHomeWifiState extends State<DiscoveryHomeWifi> {
  List<Network> _wifiList = [
    Network('epize2', 'open', 5),
    Network('sathish iphone', 'open', 5),
    Network('navaneeth', 'open', 5),
    Network('epize2', 'open', 5),
    Network('sathish iphone', 'open', 5),
    Network('navaneeth', 'open', 5),
    Network('epize2', 'open', 5),
    Network('sathish iphone', 'open', 5),
    Network('navaneeth', 'open', 5),
    Network('epize2', 'open', 5),
    Network('sathish iphone', 'open', 5),
    Network('navaneeth', 'open', 5),
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Material(
      type: MaterialType.transparency,
      child: Container(
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
          child: Column(children: <Widget>[
            Container(
                height: height * 0.15,
                child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Wifi Discovery'.toUpperCase(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        )))),
            Container(
              height: height * 0.1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text('Select a wifi to connect to your droplet.',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
            ),
            Container(
              height: height * 0.75,
              child: ListView.builder(itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => _navigateNext(context,_wifiList[index]),
                  child: WifiDiscoveyItem(_wifiList[index]),
                );
              }),
            )
          ])),
    );
  }
}

void _navigateNext(BuildContext context,Network network) {
 Navigator.push(context, SlideTopRoute(page: WldWifiPassword(Network("nn","ss",5))));

}
