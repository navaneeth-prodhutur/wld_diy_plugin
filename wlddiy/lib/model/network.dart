import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Network {
  String securityType;
  String sSID;
  int signalStrength;

  Network(this.sSID, this.securityType, this.signalStrength);

  IconData get wifisignalStrength {
    switch (signalStrength) {
      case 5:
        return Icons.signal_wifi_4_bar;

      default:
        return Icons.wifi;
    }
  }
}
