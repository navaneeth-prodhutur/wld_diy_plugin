import 'package:flutter/material.dart';
import 'package:wlddiy/model/network.dart';

class WifiDiscoveyItem extends StatelessWidget {
  final Network network;
  WifiDiscoveyItem(this.network);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          leading:
              Icon(network.wifisignalStrength, size: 20, color: Colors.grey),
          title: Text(network.sSID,
              style: TextStyle(color: Colors.black87, fontSize: 20)),
          trailing: Icon(Icons.lock, size: 15, color: Colors.grey),
        ),
      ),
    );
  }
}
