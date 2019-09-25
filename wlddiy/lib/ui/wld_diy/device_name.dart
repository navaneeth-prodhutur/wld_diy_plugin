import 'package:flutter/material.dart';
import 'package:wlddiy/model/device_name.dart';

class DeviceNameCard extends StatelessWidget {
  final DeviceName _deviceName;
  DeviceNameCard(this._deviceName);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      elevation: 0.0,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(right: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        width: 150,
        color: Colors.white,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(_deviceName.url),
                Text(_deviceName.name,
                    maxLines: 1,
                    style: TextStyle(
                        color: Color(0xff707070),
                        fontSize: 18,
                        fontWeight: FontWeight.bold))
              ],
            )),
      ),
    ));
  }
}
