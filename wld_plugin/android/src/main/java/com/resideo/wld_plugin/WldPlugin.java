package com.resideo.wld_plugin;

import android.util.Log;

import java.nio.channels.Channel;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * StormPlugin
 */
public class WldPlugin implements MethodCallHandler {
    private Registrar mRegistrar;
    private String TAG = "WldPlugin";
    private WldApplication wldApplication;
    static MethodChannel mChannel;


    public WldPlugin(Registrar lRegistrar) {
        this.mRegistrar = lRegistrar;
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        mChannel = new MethodChannel(registrar.messenger(), "wld_plugin");
        mChannel.setMethodCallHandler(new WldPlugin(registrar));
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {

        initWldApp(mChannel,call, result);
        Log.i(TAG, "call.method : " + call.method);

        OperationType operationType = OperationType.getOperationType(call.method);
        if (operationType != null) {
            Log.i(TAG, "operation Type : " + operationType.getOperationType(call.method));

            switch (operationType) {
                case WLD_DISCOVER:
                    wldApplication.discoverWldDevice(operationType);
                    break;
                case WLD_CONNECT:
                    String lAddress = call.argument("adrs").toString();
                    Log.i(TAG,"Address"+lAddress);
                    wldApplication.connectToWldDevice(result, lAddress, operationType);
                    break;
                case WLD_GET_DEVICE_ID:
                    wldApplication.handleGetDeviceId(result);
                    break;
                case WLD_START_HANDSHAKE:
                    startWldHandShake(call, result, operationType);
                    break;
                case WLD_REFRESH_WIFI_LIST:
                    wldApplication.setRefreshClicked(true);
                    wldApplication.refreshWifiList(result, operationType);
                    break;
                case WLD_ENTER_WIFI_PASSWORD:
                    String lSsid = call.argument("ssid").toString();
                    Log.i(TAG, "WLD_ENTER_WIFI_PASSWORD" + lSsid);
                    wldApplication.handleWifiItemClick(result, lSsid, operationType);
                    break;
                case WLD_CONNECT_DEVICE_TO_WIFI:
                    String lPassword = call.argument("pswd").toString();
                    wldApplication.handleConnectDeviceToWifi(result, lPassword, operationType);
                    break;
                case WLD_GET_PROVISIONING_STATUS:
                    wldApplication.handleGetProvisioningStatus(result, operationType);
                    break;
                default:
                    result.notImplemented();
                    break;
            }
        } else {
            Log.i(TAG, "invalid operation Type");
        }
    }


    

    private void startWldHandShake(MethodCall call, Result result, OperationType operationType) {
        String pubKey = call.argument("pubKey").toString();
        String deviceId = call.argument("deviceId").toString();
        wldApplication.handleStartHandshake(result, pubKey, deviceId, operationType);
    }

    private void initWldApp(MethodChannel mChannel,MethodCall call, Result result) {
        if (wldApplication == null) {
            wldApplication = new WldApplication(mChannel,mRegistrar, call, result);
        }
    }

}
