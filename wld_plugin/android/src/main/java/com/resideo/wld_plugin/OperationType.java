package com.resideo.wld_plugin;

import android.text.TextUtils;

public enum OperationType {

    WLD_DISCOVER("discover"),
    WLD_CONNECT("connect"),
    WLD_START_HANDSHAKE("starthandshake"),
    WLD_GET_DEVICE_ID("getdeviceid"),
    WLD_GET_PROVISIONING_STATUS("getprovisioningstatus"),
    WLD_REFRESH_WIFI_LIST("refreshwifilist"),
    WLD_CONNECT_DEVICE_TO_WIFI("connectdevicetowifi"),
    WLD_ENTER_WIFI_PASSWORD("enterwifipassword");

    private String operationType;

    OperationType(final String operationType) {
        this.operationType = operationType;
    }

    public static OperationType getOperationType(String value) {
        if (TextUtils.isEmpty(value)) {
            return null;
        }
        for (OperationType operationType : values()) {
            if (value.equals(operationType.operationType)) {
                return operationType;
            }
        }
        return null;
    }

    @Override
    public String toString() {
        return operationType;
    }
}