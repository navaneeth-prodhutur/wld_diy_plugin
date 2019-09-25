import 'package:flutter/material.dart';
import 'package:wlddiy/model/device_name.dart';
import 'package:wlddiy/page_route.dart';
import 'package:wlddiy/ui/wld_diy/device_name.dart';
import 'package:wlddiy/ui/wld_diy/enter_device_name_screen.dart';
import 'package:wlddiy/ui/wld_diy/wld_wifi_discovery.dart';

class WldDeviceNameing extends StatefulWidget {
  const WldDeviceNameing({Key key}) : super(key: key);

  @override
  _WldDeviceNameWidgetState createState() => _WldDeviceNameWidgetState();
}

class _WldDeviceNameWidgetState extends State<WldDeviceNameing> {
  List<DeviceName> _deviceNameList = [
    DeviceName(name: 'Basement', url: 'assets/images/washing-machine.png'),
    DeviceName(name: 'Laundry Room', url: 'assets/images/washing-machine.png'),
    DeviceName(name: 'Garage', url: 'assets/images/washing-machine.png'),
    DeviceName(name: 'Master Bathroom', url: 'assets/images/house.png'),
    DeviceName(name: 'Water Heater', url: 'assets/images/house.png'),
    DeviceName(name: 'Kitchen Sink', url: 'assets/images/washing-machine.png'),
    DeviceName(name: 'Refrigerator', url: 'assets/images/fridge.png'),
    DeviceName(name: 'Custom', url: 'assets/images/house.png', isCustom: true),
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
                  Color(0x993a93ff),
                  Color(0xff3a93ff),
                ],
              ),
            ),
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
                          child: Text('Droplet naming'.toUpperCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22)),
                        ),
                      ),
                      Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              height: height * 0.15,
                              child: Text('Select a Name for your detector',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                                height: height * 0.8,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        height: 140,
                                        padding: EdgeInsets.all(8.0),
                                        child: getCardsListView(
                                            context, _deviceNameList)),
                                  ],
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ))));
  }

  void _navigateNext(BuildContext context, DeviceName deviceNameObj) {
    if (deviceNameObj.isCustom) {
      Navigator.push(
              context, FadeTransitionPageRoute(page: DeviceNameEntryView()))
          .then((locationName) {
        print("locationName entered is $locationName");
      });
    } else {
      Navigator.push(context, SlideTopRoute(page: DiscoveryHomeWifi()));
    }
  }

  Widget getCardsListView(
      BuildContext context, List<DeviceName> locationDataList) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            child: DeviceNameCard(locationDataList[index]),
            onTap: () => _navigateNext(context, locationDataList[index]),
          );
        },
        itemCount: locationDataList.length,
      ),
    );
  }
}
