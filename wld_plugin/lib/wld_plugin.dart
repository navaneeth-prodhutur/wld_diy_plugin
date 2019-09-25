import 'dart:async';

import 'dart:convert';

 

import 'package:flutter/services.dart';

import 'package:wld_plugin/wld_model.dart';

 

class WldPlugin {

  static const MethodChannel _channel = const MethodChannel('wld_plugin');

 

  static Future<ResponseModel> enterWifiPassword(String wifiSSID) async {

    Map<String, dynamic> args = <String, dynamic>{};

    args.putIfAbsent(MethodCallArgumentsName.ssid, () => wifiSSID);

 

     final String lResFromSDK =

        await _channel.invokeMethod(MethodCallName.wifiPassword, args);

    return ResponseModel.fromJson(json.decode(lResFromSDK));

  }

 

  static Future<ResponseModel> connectDeviceToWifi(String password) async {

    Map<String, dynamic> args = <String, dynamic>{};

    args.putIfAbsent(MethodCallArgumentsName.pswd, () => password);

 

    final String lResFromSDK =

        await _channel.invokeMethod(MethodCallName.connectToDeviceWifi, args);

    return ResponseModel.fromJson(json.decode(lResFromSDK));

  }

 

  static Future<ResponseModel> refreshWifiList() async {

    final String lResFromSDK = await _channel.invokeMethod(MethodCallName.refreshWifiList);

    return ResponseModel.fromJson(json.decode(lResFromSDK));

  }

 

  static Future<ResponseModel> connectDevice(String address) async {

    Map<String, dynamic> args = <String, dynamic>{};

    args.putIfAbsent(MethodCallArgumentsName.adrs, () => address);

    final String lResFromSDK = await _channel.invokeMethod(MethodCallName.connect, args);

    return ResponseModel.fromJson(json.decode(lResFromSDK));

  }

 

  static Future<ResponseModel> get discoverDevices async {

    final String lResFromSDK = await _channel.invokeMethod(MethodCallName.wldDiscover);

    return ResponseModel.fromJson(json.decode(lResFromSDK));

  }

 

  static Future<ResponseModel> startHandshake(

      String pubKey, String deviceId) async {

    Map<String, dynamic> args = <String, dynamic>{};

    args.putIfAbsent(MethodCallArgumentsName.pubKey, () => pubKey);

    args.putIfAbsent(MethodCallArgumentsName.deviceId, () => deviceId);

    final String lResFromSDK =

        await _channel.invokeMethod(MethodCallName.startHandShake, args);

    return ResponseModel.fromJson(json.decode(lResFromSDK));

    ;

  }

 

  static Future<ResponseModel> getDeviceId() async {

    final String lResFromSDK = await _channel.invokeMethod(MethodCallName.getdeviceid);

    return ResponseModel.fromJson(json.decode(lResFromSDK));

  }

 

  static Future<ResponseModel> getProvisioningStatus() async {

    final String lResFromSDK =

        await _channel.invokeMethod(MethodCallName.getProvisioningStatus);

    return ResponseModel.fromJson(json.decode(lResFromSDK));

  }

  static void setMethodCallHandler(Future<dynamic> handler(MethodCall call)){
  _channel.setMethodCallHandler(handler);
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

 

class MethodCallName {

  static final String wldDiscover = "discover";

  static final String connect = "connect";

  static final String getdeviceid = "getdeviceid";

  static final String getProvisioningStatus = "getprovisioningstatus";

  static final String startHandShake = "starthandshake";

  static final String refreshWifiList = "refreshwifilist";

  static final String connectToDeviceWifi = "connectdevicetowifi";

  static final String wifiPassword = "enterwifipassword";

}

 

class MethodCallArgumentsName {

    static final String pubKey = "pubKey";

    static final String deviceId = "deviceId";

    static final String adrs = "adrs";

    static final String pswd = "pswd";

    static final String ssid = "ssid";

  }