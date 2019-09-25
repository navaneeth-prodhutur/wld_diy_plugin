package com.resideo.wld_plugin;

public enum WldErrorType {
    onBleConnectionTimeout,
    onTimeOut,
    onDiscoveryToDevice,
    onConnectionToDevice,
    onHandShakeWithDevice,
    onDeviceOnBoard,
    onConnectingToHoneywell,
    onNoSharedSecret,
    onServerDeviceIdEmpty,
    onError,
    onProvisioning,
    onPairingFailed,
    onBleWifiDiscovery,
    onBleNoWifiDiscovery,
    onNetworkUnavailable,
    onDetectorConnectionLost,
    onConnectToWifiFailAlert,
    onInternetFailed,
    onCloudDisconnected,
    onCloudServerFailed,
    onConnectingToHoneywellCloud,
    onActivating,
    onCloudConnectionFailed,
    onBleDisconnected,
    onWiFiConnectionFailure,
    onNetworkConnectPasswordInvalid,
    onDeviceStatusInternetConnectionFailed;
}
