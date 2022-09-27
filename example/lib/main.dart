import 'dart:math';

import "package:flutter/material.dart";
import "package:shurjopay_sdk/shurjopay_sdk.dart";

/// main method for app entry point.
void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  /// shurjoPay SDK declaration.
  late ShurjopaySdk shurjopaySdk;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("shurjoPay SDK - shurjoMukhi Ltd"),
        ),
        body: Center(
          child: ElevatedButton(
            child: const Text("Pay By shurjoPay SDK"),
            onPressed: () {
              /// Call onShurjoPaySdk method with BuildContext.
              onShurjoPaySdk(context);
            },
          ),
        ),
      ),
    );
  }

  /// onShurjoPaySdk Method
  ///
  /// onShurjoPaySdk(BuildContext context) accept BuildContext parameter.
  void onShurjoPaySdk(BuildContext context) {
    /// shurjoPay SDK Request Data
    ///
    /// TODO request data model setup
    /// RequiredRequestData is user for shurjoPay payment request.
    RequiredRequestData requiredRequestData = requestData;
    requiredRequestData.onPrint();

    /// shurjoPay Response Listener
    ///
    /// TODO request response listener setup
    /// After request in shurjoPay SDK return and respons by this listener.
    shurjopaySdk = ShurjopaySdk(
      /// TODO you get success response, if the transection is succefully completed.
      onSuccess: (BuildContext context, ErrorSuccess errorSuccess) {
        switch (errorSuccess.esType) {
          case ESType.INTERNET_SUCCESS:
            debugPrint(
                "DEBUG_LOG_PRINT: surjoPay SDK SUCCESS: ${errorSuccess.message}");
            //return;
            break;
          case ESType.SUCCESS:
            //debugPrint("DEBUG_LOG_PRINT: surjoPay SDK SUCCESS: ${errorSuccess.message}");
            onTransaction(errorSuccess.transactionInfo);
            //return;
            break;
        }
        debugPrint(
            "DEBUG_LOG_PRINT: surjoPay SDK SUCCESS: ${errorSuccess.esType.name}");
        if (errorSuccess.isLastCallback) {
          //Navigator.of(context, rootNavigator: true).pop();
        }
      },

      /// TODO you get failed response, if the transection is failed or canceled.
      onFailed: (BuildContext context, ErrorSuccess errorSuccess) {
        switch (errorSuccess.esType) {
          case ESType.INTERNET_ERROR:
            debugPrint(
                "DEBUG_LOG_PRINT: surjoPay SDK ERROR: ${errorSuccess.message}");
            //return;
            break;
          case ESType.HTTP_CANCEL:
            debugPrint(
                "DEBUG_LOG_PRINT: surjoPay SDK ERROR: ${errorSuccess.message}");
            //return;
            break;
          case ESType.ERROR:
            debugPrint(
                "DEBUG_LOG_PRINT: surjoPay SDK ERROR: ${errorSuccess.message}");
            //return;
            break;
        }
        debugPrint(
            "DEBUG_LOG_PRINT: surjoPay SDK ERROR: ${errorSuccess.message}");
        if (errorSuccess.isLastCallback) {
          //Navigator.of(context, rootNavigator: true).pop();
        }
      },
    );

    /// shurjoPay SDK Payment Request
    ///
    /// TODO payment request setup
    /// shurjoPay payment request by makePayment method.
    /// It takes context, sdkType and request data.
    shurjopaySdk.makePayment(
      context: context,

      /// TODO live/sandbox request
      sdkType: AppConstants.SDK_TYPE_SANDBOX,
      data: requiredRequestData,
    );
  }

  void onTransaction(TransactionInfo? transactionInfo) {
    debugPrint("DEBUG_LOG_PRINT: surjoPay SDK SUCCESS TransactionInfo:");
    transactionInfo?.onPrint();
  }

  RequiredRequestData get requestData {
    int orderId = Random().nextInt(1000);
    RequiredRequestData requiredRequestData = RequiredRequestData(
      username: "sp_sandbox",
      password: "pyyk97hu&6u6",
      prefix: "NOK",
      currency: "BDT",
      amount: 1,
      orderId: "NOK$orderId",
      discountAmount: 0,
      discPercent: 0,
      customerName: "customer name",
      customerPhone: "01711486915",
      customerEmail: null,
      customerAddress: "customer address",
      customerCity: "customer city",
      customerState: null,
      customerPostcode: "1212",
      customerCountry: null,
      returnUrl: "https://www.sandbox.shurjopayment.com/return_url",
      cancelUrl: "https://www.engine.shurjopayment.com/cancel_url",
      clientIp: "127.0.0.1",
      value1: null,
      value2: null,
      value3: null,
      value4: null,
    );
    //requiredRequestData = ShurjoPayUser().getSandboxUser();
    //debugPrint("DEBUG_LOG_PRINT: REQUEST_DATA: ${requiredRequestData}");
    return requiredRequestData;
  }
}
