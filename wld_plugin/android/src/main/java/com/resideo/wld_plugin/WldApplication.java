package com.resideo.wld_plugin;

import android.content.Context;
import android.util.Log;
import android.widget.Toast;

import java.nio.channels.Channel;
import java.util.ArrayList;
import java.util.List;

import devkit.honeywell.com.corelogic.base.BaseDevice;
import devkit.honeywell.com.corelogic.base.BaseDeviceRegistration;
import devkit.honeywell.com.corelogic.base.DevKitLogicCallback;
import devkit.honeywell.com.corelogic.base.logger.BaseLogLevel;
import devkit.honeywell.com.corelogic.base.model.IRIQnADataModel;
import devkit.honeywell.com.corelogic.base.model.notification.NotificationErrorType;
import devkit.honeywell.com.corelogic.base.model.notification.NotificationType;
import devkit.honeywell.com.corelogic.base.model.notification.State;
import devkit.honeywell.com.corelogic.base.model.wifi.Network;
import devkit.honeywell.com.corelogic.ble.DeviceConnectionListener;
import devkit.honeywell.com.corelogic.ble.blecontroller.BleDevice;
import devkit.honeywell.com.wldlogic.DevkitLogic;
import devkit.honeywell.com.wldlogic.WldFlowLogic;
import devkit.honeywell.com.wldlogic.common.WldNotificationType;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class WldApplication {

    private WldFlowLogic mLogic;
    private MethodChannel.Result mResultFromDevKit;
    private MethodChannel.Result mResultFromError;
    private MethodChannel.Result mResultFromOnBleChanges;


    //    private MethodChannel.Result resultWifiConnect;
    //    private MethodChannel.Result resultRefreshWifi;
    //    private MethodChannel.Result resultConfigureWifi;
    //    private MethodChannel.Result resultHandshake;
    //    private MethodChannel.Result mConnectToWldDevice;
    //    private MethodChannel.Result resultDeviceProvisioningState;
    //    private MethodChannel.Result resultDeviceOnboard;
    //    private MethodChannel.Result resultGetDevice;
    //    private MethodCall callChange;
    private String mSavedSsid;
    private boolean isRefreshClicked = false;
    private List<BleDevice> listOfDevices = new ArrayList<>();
    private List<Network> listOfWifiNetworks = new ArrayList<>();
    private Context ctx;
    private MethodChannel mChannel;
    private PluginRegistry.Registrar registrarVal;
    private String TAG = WldApplication.class.getName();

    private OperationType mOperationType;

    public boolean isRefreshClicked() {
        return isRefreshClicked;
    }

    public void setRefreshClicked(boolean refreshClicked) {
        isRefreshClicked = refreshClicked;
    }

    private DeviceConnectionListener mBlePairingListener = new DeviceConnectionListener() {
        @Override
        public void onDeviceDiscoverySuccess(List<BaseDevice> mDeviceList) {
            Log.i(TAG, "Device List size " + mDeviceList.size());
            BleDevice device = null;
            if (mDeviceList != null && mDeviceList.size() > 0) {
                for (int i = 0; i < mDeviceList.size(); i++) {
                    device = (BleDevice) mDeviceList.get(i);
                    listOfDevices.add(device);
                    Log.i(TAG, "device macadrs " + device.getMacAddress());
                }
            }
            ResponseModel responseModel = new ResponseModel(mOperationType.toString(), ResponseType.Success.toString(),
                    listOfDevices);
            mResultFromDevKit.success(responseModel.toString());
        }

        @Override
        public void onPaired() {
            handleCallback("device Paired");
            Log.i(TAG, "device Paired");

        }

        @Override
        public void onPairingFailed() {
            ResponseModel model = new ResponseModel(mOperationType.toString(), ResponseType.Failure.toString(),
                    WldErrorType
                            .onPairingFailed);
            handleErrorCallback(model);
            Log.i(TAG, "device Pairing failed");
        }

        @Override
        public void onTimedOut() {
            ResponseModel model = new ResponseModel(mOperationType.toString(), ResponseType.Failure.toString(),
                    WldErrorType
                            .onTimeOut);
            handleErrorCallback(model);
            Log.i(TAG, "device Pairing timeout");
        }

        @Override
        public void onDisconnected() {
//            mResultFromError.error("ON_DISCONNECTED", "device Disconnected", null);
            //mResultFromError.error("ON_DISCONNECTED", "device Disconnected", null);
            ResponseModel model = new ResponseModel(mOperationType.toString(), ResponseType.Failure.toString(),
                    WldErrorType
                            .onBleDisconnected);
            handleErrorCallback(model);
            Log.i(TAG, "device disconnected");
        }
    };
    private DevKitLogicCallback mDevKitLogicCallback = new DevKitLogicCallback() {
        @Override
        public void onLog(int i, String s) {
            Log.i(TAG, "onLog " + s);
        }

        @Override
        public void onDeviceOnboardStateChange(final NotificationType notificationType, final State state,
                                               NotificationErrorType
                                                       notificationErrorType) {

            final WldNotificationType wldNotificationType = (WldNotificationType) notificationType;
//            Log.i(TAG, "onDeviceOnboardStateChange : notificationType" + notificationType.toString());
//            Log.i(TAG, "onDeviceOnboardStateChange : State" + state.name());
            Log.i("navi", "onDeviceOnboardStateChange : notificationType : " + wldNotificationType.toString());

            registrarVal.activity().runOnUiThread(new Runnable() {
                @Override
                public void run() {

                    if (state == State.Failed) {
                        handleCallback(" Something went wrong while Setup");
                    }

                    switch (wldNotificationType) {
                        case Communication:

                            if (state == State.Failed) {
                                Log.i("navi", "state : " + state.toString());
                                mResultFromError.error("COMMUNICATION_FAILED", "Communication Failed", null);
                                handleCallback("Communication Failed : state = " + state.name());
                               /* ResponseModel responseModel = new ResponseModel(mOperationType.toString(),
                                        ResponseType.Failure.toString(), WldConstants.wld_device_discovery);
                                mResultFromDevKit.error(WldErrorType.onDiscoveryToDevice.toString(), responseModel
                                        .toString(), null);*/

                            }

                            break;

                        case DeviceDiscovery:
                            if (state == State.Failed) {
                                handleCallback("discovery failed, retry");
                                ResponseModel responseModel = new ResponseModel(mOperationType.toString(),
                                        ResponseType.Failure.toString(), WldConstants.wld_device_discovery);
                                handleErrorCallback(responseModel);
                            }
                            break;
                        case DeviceConnect:
                            processDeviceConnect(state);
                            break;
                        case Handshake:
                            processHandShakeResponse(state);
                            break;
                        case WifiDiscovery:
                            processWifiDiscovery(state);
                            break;
                        case WifiConfiguration:
                            processWifiConfigration(state);
                            break;
                        case Provisioning:
                            processProvisioning(state);
                            break;
                        case DeviceOnBoard:
                            processDeviceOnboarding(state);
                            break;
                    }

                }
            });
        }

        @Override
        public void onGetISU(IRIQnADataModel iriQnADataModel) {
            Log.i(TAG, "onGetISU");
        }

        @Override
        public void onSetISU(boolean b) {
            Log.i(TAG, "onSetISU");
        }

        @Override
        public void onWifiNetworkListAvailable(final List<Network> list) {

            registrarVal.activity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    ResponseModel responseModel = new ResponseModel(mOperationType.toString(), ResponseType
                            .Success.toString(), list);
                    if (isRefreshClicked) {
                        mResultFromDevKit.success(responseModel.toString());
                    } else {
                        mResultFromDevKit.success(responseModel.toString());
                    }
                }
            });
        }
    };

    private void processDeviceConnect(State state) {
        if (state == State.Success) {
            ResponseModel responseModel;
            if (mLogic.getDeviceId() != null && !mLogic.getDeviceId().isEmpty()) {
                handleCallback("Mac Id: " + mLogic.getDeviceId());
                responseModel = new ResponseModel(mOperationType.toString(),
                        ResponseType.Success.toString(), mLogic.getDeviceId());

            } else {
                responseModel = new ResponseModel(mOperationType.toString(),
                        ResponseType.Success.toString(), WldConstants.wld_device_connect);
                mResultFromDevKit.success(responseModel.toString());
            }
            mResultFromDevKit.success(responseModel.toString());
        } else if (state == State.Failed) {
            handleCallback("connection failed, retry");
            ResponseModel responseModel = new ResponseModel(mOperationType.toString(),
                    ResponseType.Failure.toString(), WldConstants.wld_device_connect);
            handleErrorCallback(responseModel);
        }
    }

    private void processDeviceOnboarding(State state) {
        ResponseModel responseModel;
        switch (state) {
            case Initiated:
                break;
            case Success:
                responseModel = new ResponseModel(mOperationType.toString(),
                        ResponseType.Success.toString(), WldConstants.wld_device_onboard);
                mResultFromDevKit.success(responseModel.toString());
                break;
            case Failed:
                responseModel = new ResponseModel(mOperationType.toString(),
                        ResponseType.Failure.toString(), WldConstants.wld_device_onboard);
                handleErrorCallback(responseModel);
                break;
        }
    }

    private void processProvisioning(State state) {
        ResponseModel responseModel;
        switch (state) {
            case Success:
                Log.d("TAG", "do nothing");
                break;
            case Failed:
                responseModel = new ResponseModel(mOperationType.toString(),
                        ResponseType.Failure.toString(), WldConstants.wld_device_provisioning);
                handleErrorCallback(responseModel);
                break;
            case Initiated:
                responseModel = new ResponseModel(mOperationType.toString(),
                        ResponseType.Success.toString(), WldConstants.wld_device_provisioning);
                mResultFromDevKit.success(responseModel.toString());
                break;

        }

    }

    private void processWifiConfigration(State state) {
        ResponseModel responseModel;
        switch (state) {
            case Failed:
                responseModel = new ResponseModel(mOperationType.toString(),
                        ResponseType.Failure.toString(), WldConstants.wld_device_wifi_configuration);
                handleErrorCallback(responseModel);
                break;
            case Success:
                responseModel = new ResponseModel(mOperationType.toString(),
                        ResponseType.Success.toString(), WldConstants.wld_device_wifi_configuration);
                mResultFromDevKit.success(responseModel.toString());
                break;
            case Initiated:
                Log.d("TAG", "do nothing");
                break;

        }
    }

    private void processWifiDiscovery(State state) {
        if (state == State.Failed) {
            ResponseModel responseModel = new ResponseModel(mOperationType.toString(),
                    ResponseType.Failure.toString(), WldConstants.wld_device_wifi_discovery);
            handleErrorCallback(responseModel);
        }
    }

    private void processHandShakeResponse(State state) {
        ResponseModel responseModel;
        switch (state) {
            case Failed:
                responseModel = new ResponseModel(mOperationType.toString(),
                        ResponseType.Failure.toString(), WldConstants.wld_device_handshake);
                handleErrorCallback(responseModel);

                break;
            case Success:
                responseModel = new ResponseModel(mOperationType.toString(),
                        ResponseType.Success.toString(), WldConstants.wld_device_handshake);
                mResultFromDevKit.success(responseModel.toString());
                break;
            case Initiated:
                Log.d("TAG", "do nothing");
                break;
        }

    }


    public WldApplication(Context context, MethodCall call, MethodChannel.Result result) {
        init(context);
        ctx = context;
        setResultCallbacks(result);
        //        callChange = call;
    }

    public WldApplication(MethodChannel channel,PluginRegistry.Registrar registrar, MethodCall call, MethodChannel.Result result) {
        mChannel = channel;
        registrarVal = registrar;
        init(registrarVal.context());
        ctx = registrarVal.context();
        setResultCallbacks(result);
        //        callChange = call;
    }

    private void init(Context context) {
        DevkitLogic devkitLogic = new DevkitLogic();

        devkitLogic.setLogLevel(BaseLogLevel.DEBUG);

        devkitLogic.setDevKitCallBackObject(mBlePairingListener, mDevKitLogicCallback);

        BaseDeviceRegistration registration = devkitLogic.getOnboardLogic(context);
        if (registration instanceof WldFlowLogic) {
            mLogic = (WldFlowLogic) registration;
        } else {
            Log.d(TAG, "Error initializing SDK");
        }
    }


    public void handleStartHandshake(MethodChannel.Result result, String pubKey, String deviceId, OperationType
            operationType) {
        this.mOperationType = operationType;
        mOperationType = OperationType.WLD_START_HANDSHAKE;
        setResultCallbacks(result);
        mLogic.setKeyAndReferenceId(pubKey, deviceId);
    }

    public void handleGetDeviceId(MethodChannel.Result result) {
        mOperationType = OperationType.WLD_GET_DEVICE_ID;
        ResponseModel responseModel;
        if (mLogic.getDeviceId() != null && !mLogic.getDeviceId().isEmpty()) {
            handleCallback("Mac Id: " + mLogic.getDeviceId());
            responseModel = new ResponseModel(mOperationType.toString(),
                    ResponseType.Success.toString(), mLogic.getDeviceId());
            result.success(responseModel.toString());
        } else {
            responseModel = new ResponseModel(mOperationType.toString(),
                    ResponseType.Failure.toString(), WldConstants.wld_device_get);
            handleErrorCallback(responseModel);
        }

    }

    public void handleGetProvisioningStatus(MethodChannel.Result result, OperationType operationType) {
        this.mOperationType = operationType;
        setResultCallbacks(result);

    }

    private void setResultCallbacks(MethodChannel.Result result) {
        mResultFromDevKit = result;
        mResultFromError = result;
    }

    public void refreshWifiList(MethodChannel.Result result, OperationType operationType) {
        this.mOperationType = operationType;
        mOperationType = OperationType.WLD_REFRESH_WIFI_LIST;
        setResultCallbacks(result);
        mLogic.getWifiList();
    }


    private void handleCallback(final String message) {
        //Toast.makeText(ctx, message, Toast.LENGTH_SHORT).show();
        registrarVal.activity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Toast.makeText(ctx, message, Toast.LENGTH_SHORT).show();
            }
        });
    }

    private void handleErrorCallback(final ResponseModel responseModel) {
        //Toast.makeText(ctx, message, Toast.LENGTH_SHORT).show();
        registrarVal.activity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                mChannel.invokeMethod("errorCallBack",responseModel.toString());
            }
        });
    }

    /**
     * Step 1
     * which will discover for wld device which is broadcasting in the BLE MODE.
     *
     * @param operationType
     */

    public void discoverWldDevice(OperationType operationType) {
        this.mOperationType = operationType;
        mLogic.discoverDevices();
    }

    /**
     * Step 2
     * After discovering the device to connect to the device which user selected.
     *
     * @param result
     * @param address
     * @param operationType
     */
    public void connectToWldDevice(MethodChannel.Result result, String address, OperationType operationType) {
        this.mOperationType = operationType;
        setResultCallbacks(result);

        for (int i = 0; i < listOfDevices.size(); i++) {
            Log.i(TAG, "Device Selected is " + listOfDevices.get(i).getWifiMacAddress());
            Log.i(TAG, "Device Selected is " + listOfDevices.get(i).getWifiMacAddress());
            if (address.equals(listOfDevices.get(i).getWifiMacAddress())) {
                Log.i(TAG, "Device Selected is " + address);
                mLogic.connectDevice(listOfDevices.get(i), false);
            } else {
                Log.i(TAG, "invalid Mac id");
            }
        }
    }

    public void handleConnectDeviceToWifi(MethodChannel.Result result, String password, OperationType
            operationType) {
        this.mOperationType = operationType;
        mOperationType = OperationType.WLD_CONNECT_DEVICE_TO_WIFI;
        setResultCallbacks(result);
        for (int i = 0; i < listOfWifiNetworks.size(); i++) {
            if (mSavedSsid.equals(listOfWifiNetworks.get(i).getSSID())) {
                Log.i(TAG, "ssid " + mSavedSsid);
                listOfWifiNetworks.get(i).setPassword(password);
                mLogic.setWifi(listOfWifiNetworks.get(i));
            }
        }

    }

    public void handleWifiItemClick(MethodChannel.Result result, String ssid, OperationType operationType) {
        this.mOperationType = operationType;
        mOperationType = OperationType.WLD_ENTER_WIFI_PASSWORD;
        mSavedSsid = ssid;
        ResponseModel responseModel = new ResponseModel(mOperationType.toString(),
                ResponseType.Success.toString(), mSavedSsid);

        result.success(responseModel.toString());
    }

}
