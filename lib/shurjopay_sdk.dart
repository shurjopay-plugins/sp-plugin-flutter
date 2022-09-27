import "dart:async";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:shurjopay_sdk/shurjopay_sdk.dart';
import "package:shurjopay_sdk/src/sdk/shurjopay_sdk_plugin.dart";
import "package:shurjopay_sdk/src/utils/pro_internet.dart";

/// Exported data and class
export "src/model/required_request_data.dart";
export "src/model/data_transaction_info.dart";
export "src/utils/app_constants.dart";
export "src/model/error_success.dart";
export "src/model/es_type.dart";

/// shurjoPay SDK Class
class ShurjopaySdk {
  late final Function(BuildContext context, ErrorSuccess errorSuccess)
  onSuccess;
  late final Function(BuildContext context, ErrorSuccess errorSuccess) onFailed;
  late final Function(BuildContext context, String message) onInternetFailed;

  bool _isShowDialog = false;

  static const MethodChannel _channel = MethodChannel('shurjopay_sdk');
  List<String> errorMsgList = <String>[];

  ShurjopaySdk({required this.onSuccess, required this.onFailed});

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod("getPlatformVersion");
    return version;
  }

  Future<void> makePayment({
    required BuildContext context,
    required String sdkType,
    required RequiredRequestData data,
  }) async {
    _isShowDialog = true;
    errorMsgList.clear();
    ErrorSuccess errorSuccess = ErrorSuccess(ESType.SUCCESS, null,
        "Input field validation success");
    String errorMsg = "No error";
    bool haveError = false;
    // Internet connection check
    _isShowDialog = _showLoaderDialog(context);
    errorSuccess = ErrorSuccess(ESType.INTERNET_SUCCESS, null,
        "Internet connected");
    bool haveInternet = await ProInternet.isInternet();
    if (!haveInternet) {
      _onDismissDialog(context);
      errorSuccess = ErrorSuccess(ESType.INTERNET_ERROR, null,
          "Internet connection error. Please check your internet connection");
      onFailed(context, errorSuccess);
      return;
    }
    onSuccess(context, errorSuccess);
    ShurjopaySdkPlugin sdkPlugin = ShurjopaySdkPlugin(
      onSuccess: (BuildContext context, ErrorSuccess errorSuccess) {
        onSuccess(context, errorSuccess);
      },
      onFailed: (BuildContext context, ErrorSuccess errorSuccess) {
        onFailed(context, errorSuccess);
      },
      onDismissDialog: () {
        _onDismissDialog(context);
      },
    );
    sdkPlugin.makePayment(context, sdkType, data);
  }

  bool _showLoaderDialog(BuildContext context) {
    if (_isShowDialog) {
      return true;
    }
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 7),
                  child: const Text("Loading...")),
            ],
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    return true;
  }

  void _onDismissDialog(BuildContext context) {
    if (_isShowDialog) {
      Navigator.pop(context, true);
      _isShowDialog = false;
    }
    while (_isShowDialog) {
      _onDismissDialog(context);
    }
    Navigator.of(context, rootNavigator: true).pop("dialog");
  }

  bool validateUserName(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
