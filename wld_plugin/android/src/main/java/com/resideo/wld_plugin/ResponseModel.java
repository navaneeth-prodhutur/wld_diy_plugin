package com.resideo.wld_plugin;

import com.google.gson.Gson;
import com.google.gson.annotations.SerializedName;

import java.util.List;

public class ResponseModel<T> {

    @SerializedName("operationType")
    private String mOperationType;

    @SerializedName("message")
    private T mMessage;

    @SerializedName("code")
    private String Code;

    @SerializedName("objectsList")
    private List<T> mObjectsList;

    public ResponseModel(String mOperationType, String code, T mMessage, List<T> mObjectsList) {
        this.mOperationType = mOperationType;
        this.mMessage = mMessage;
        Code = code;
        this.mObjectsList = mObjectsList;
    }

    public ResponseModel(String mOperationType, String code, List<T> mObjectsList) {
        this.mOperationType = mOperationType;
        Code = code;
        this.mObjectsList = mObjectsList;
    }

    public ResponseModel(String mOperationType, String code, T mMessage) {
        this.mOperationType = mOperationType;
        this.mMessage = mMessage;
        Code = code;
    }


    @Override
    public String toString() {
        return new Gson().toJson(this);
    }
}
