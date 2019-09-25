import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:wld_plugin/wld_model.dart';

class WldPlugin1 {
  static const MethodChannel _channel = const MethodChannel('wld_plugin');

  static void setMethodCallBackHandler(
      Future<dynamic> handler(MethodCall call)) {
    _channel.setMethodCallHandler(handler);
  }





  

  static Future<ResponseModel> enterWifiPassword(String wifiSSID) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("ssid", () => wifiSSID);

    final String lResFromSDK =
        await _channel.invokeMethod('enterwifipassword', args);
    return ResponseModel.fromJson(json.decode(lResFromSDK));
  }

  static Future<ResponseModel> connectDeviceToWifi(String password) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("pswd", () => password);

    final String lResFromSDK =
        await _channel.invokeMethod('connectdevicetowifi', args);
    return ResponseModel.fromJson(json.decode(lResFromSDK));
  }

  static Future<ResponseModel> refreshWifiList() async {
    final String lResFromSDK = await _channel.invokeMethod('refreshwifilist');
    return ResponseModel.fromJson(json.decode(lResFromSDK));
  }

  static Future<ResponseModel> connectDevice(String address) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("adrs", () => address);
    final String lResFromSDK = await _channel.invokeMethod('connect', args);
    return ResponseModel.fromJson(json.decode(lResFromSDK));
  }

  static Future<ResponseModel> startHandshake(
      String pubKey, String deviceId) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("pubKey", () => pubKey);
    args.putIfAbsent("deviceId", () => deviceId);
    final String lResFromSDK =
        await _channel.invokeMethod('starthandshake', args);
    return ResponseModel.fromJson(json.decode(lResFromSDK));
    ;
  }

  static Future<ResponseModel> getDeviceId() async {
    final String lResFromSDK = await _channel.invokeMethod('getdeviceid');
    return ResponseModel.fromJson(json.decode(lResFromSDK));
  }

  static Future<ResponseModel> getProvisioningStatus() async {
    final String lResFromSDK =
        await _channel.invokeMethod('getprovisioningstatus');
    return ResponseModel.fromJson(json.decode(lResFromSDK));
  }
}

class Network {
  String securityType;
  String sSID;
  String signalStrength;

  Network(this.sSID, this.securityType, this.signalStrength);

  static Network fromJson(dynamic json) {
    return Network(
        json['mSSID'], json['mSecurityType'], json['mSignalStrength']);
  }
}

class BleDevice {
  String mDeviceName;
  String mMacAddress;
  String mWifiMacAddress;

  BleDevice(this.mDeviceName, this.mMacAddress, this.mWifiMacAddress);

  static BleDevice fromJson(dynamic json) {
    return BleDevice(
        json['mDeviceName'], json['mMacAddress'], json['mWifiMacAddress']);
  }
}
