import 'package:flutter/material.dart';
import 'package:wlddiy/model/location_name.dart';
import 'package:wlddiy/page_route.dart';
import 'package:wlddiy/ui/wld_diy/device_name.dart';
import 'package:wlddiy/ui/wld_diy/enter_location_screen.dart';
import 'package:wlddiy/ui/wld_diy/location_name.dart';
import 'package:wlddiy/ui/wld_diy/wld_device_naming.dart';

class WldLocationName extends StatefulWidget {
  const WldLocationName({Key key}) : super(key: key);

  @override
  _WldLocationNameState createState() => _WldLocationNameState();
}

class _WldLocationNameState extends State<WldLocationName> {
  List<LocationName> _locationDataList = [
    LocationName('Home', 'assets/images/house.png',false),
    LocationName('Guest House', 'assets/images/police-station.png',false),
    LocationName('Office', 'assets/images/work.png',false),
    LocationName('custom', 'assets/images/house.png',true),
  ];

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
                  child: Text('Location Details'.toUpperCase(),
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
                      child: Center(
                        child: Text(
                            'Select the location where you want to install your droplet .',
                            textAlign: TextAlign.left,
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ),
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
                                    context, _locationDataList)),
                          ],
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _navigateNext(BuildContext context, LocationName deviceNameObj) {
    if (deviceNameObj.isCustom) {
      Navigator.push(
              context, FadeTransitionPageRoute(page: LocationEntryView()))
          .then((locationName) {
        print("locationName entered is $locationName");
      });
    } else {
        Navigator.push(context, SlideTopRoute(page: WldDeviceNameing()));
    }
  }

  Widget getCardsListView(
      BuildContext context, List<LocationName> locationDataList) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            child: LocationNameCard(locationDataList[index]),
            onTap: () => _navigateNext(context,locationDataList[index]),
          );
        },
        itemCount: locationDataList.length,
      ),
    );
  }
}
