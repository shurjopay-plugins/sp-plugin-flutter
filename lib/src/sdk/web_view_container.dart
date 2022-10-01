import "dart:convert";
import "package:http/http.dart" as http;
import "package:flutter/material.dart";
import "package:webview_flutter/webview_flutter.dart";
import "package:shurjopay_sdk/shurjopay_sdk.dart";
import "package:shurjopay_sdk/src/model/data_response_checkout.dart";
import "package:shurjopay_sdk/src/model/data_token.dart";
import "package:shurjopay_sdk/src/sdk/api_client.dart";

import "../utils/utility.dart";

class WebViewContainer extends StatefulWidget {
  final Function(BuildContext context, ErrorSuccess errorSuccess) onSuccess;
  final Function(BuildContext context, ErrorSuccess errorSuccess) onFailed;

  final Function() onDismissDialog;
  final RequiredRequestData requestData;
  final String apiUrl;
  final String sdkType;
  final Token tokenModel;
  final CheckoutResponseData checkoutModel;

  const WebViewContainer({
    required this.requestData,
    required this.apiUrl,
    required this.sdkType,
    required this.checkoutModel,
    required this.tokenModel,
    //required this.loadingDialog,
    required this.onSuccess,
    required this.onFailed,
    required this.onDismissDialog,
  });

  @override
  WebViewContainerState createState() => WebViewContainerState(
        requestData: requestData,
        apiUrl: apiUrl,
        sdkType: sdkType,
        tokenModel: tokenModel,
        checkoutModel: checkoutModel,
        onSuccess: (BuildContext context, ErrorSuccess errorSuccess) {
          onSuccess(context, errorSuccess);
        },
        onFailed: (BuildContext context, ErrorSuccess errorSuccess) {
          onFailed(context, errorSuccess);
        },
        onDismissDialog: () {
          onDismissDialog();
        },
      );
}

class WebViewContainerState extends State<WebViewContainer> {
  final Function(BuildContext context, ErrorSuccess errorSuccess) onSuccess;
  final Function(BuildContext context, ErrorSuccess errorSuccess) onFailed;

  final Function() onDismissDialog;
  final RequiredRequestData requestData;
  final String apiUrl;
  final String sdkType;
  final Token tokenModel;
  final CheckoutResponseData checkoutModel;
  late WebViewController webViewController;
  bool _isShowDialog = false;
  //late LoadingDialog _loadingDialog;
  bool _isVerified = false;

  WebViewContainerState({
    required this.requestData,
    required this.apiUrl,
    required this.sdkType,
    required this.checkoutModel,
    required this.tokenModel,
    //required this.loadingDialog,
    required this.onSuccess,
    required this.onFailed,
    required this.onDismissDialog,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async {
          String? url = await webViewController.currentUrl();
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: WebView(
              initialUrl: apiUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController argWebViewController) {
                webViewController = argWebViewController;
              },
              onPageFinished: (String url) {},
              onPageStarted: (String url) {
                if (url.contains(requestData.cancelUrl.toString())) {
                  Navigator.pop(context);
                  setState(() {
                    ErrorSuccess errorSuccess = ErrorSuccess(ESType.HTTP_CANCEL, null, "${AppConstants.PAYMENT_CANCELLED}");
                    onFailed(context, errorSuccess);
                  });
                  return;
                }
                if (url.contains(requestData.returnUrl.toString()) && url.contains("order_id")) {
                  _verifyPayment(context, sdkType);
                  return;
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _verifyPayment(BuildContext context, String sdkType) async {
    _isVerified = true;
    ErrorSuccess errorSuccess = ErrorSuccess(ESType.SUCCESS, null, "", isLastCallback: true);
    var url = Uri.parse(ApiClient.getApiClient(sdkType).verify());
    try {
      final response = await http.post(url, body: {
        "order_id": checkoutModel.spOrderId,
      }, headers: {
        "Accept": "application/json",
        "Authorization": "${tokenModel.tokenType} ${tokenModel.token}",
      });
      //Navigator.of(context).popUntil((route) => route.settings.name == "shurjoPayView");
      List<dynamic> userData = List<dynamic>.from(json.decode(response.body));
      TransactionInfo transactionInfo =
          TransactionInfo.fromJson(userData[userData.length - 1]);
      //Navigator.of(context, rootNavigator: true).pop("shurjoPaySDKView");
      //Navigator.of(context, rootNavigator: true).pop();
      if (transactionInfo.spCode == 1000) {
        errorSuccess = ErrorSuccess(ESType.SUCCESS, transactionInfo,
            "Payment successfull",
            isLastCallback: true);
        onSuccess(context, errorSuccess);
      } else {
        errorSuccess = ErrorSuccess(ESType.ERROR, transactionInfo,
            "Error ${transactionInfo.spMassage}",
            isLastCallback: true);
        onFailed(context, errorSuccess);
      }
      //Navigator.of(context, rootNavigator: true).pop("shurjoPaySDKView");
    } catch (e) {
      errorSuccess = ErrorSuccess(
          ESType.ERROR, null, "${e.toString()}",
          isLastCallback: true);
      onFailed(context, errorSuccess);
      Navigator.of(context, rootNavigator: true).pop("shurjoPaySDKView");
    }
  }
}
