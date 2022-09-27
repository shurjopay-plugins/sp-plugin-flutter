import "dart:async";
import "dart:convert";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:shurjopay_sdk/shurjopay_sdk.dart";
import "package:shurjopay_sdk/src/model/data_response_checkout.dart";
import "package:shurjopay_sdk/src/model/data_token.dart";
import "package:shurjopay_sdk/src/sdk/api_client.dart";
import "package:shurjopay_sdk/src/sdk/web_view_container.dart";

class ShurjopaySdkPlugin {
  late BuildContext _context;

  late final Function(BuildContext context, ErrorSuccess errorSuccess)
      onSuccess;
  late final Function(BuildContext context, ErrorSuccess errorSuccesse)
      onFailed;
  late final Function() onDismissDialog;
  late String _sdkType;
  late RequiredRequestData _data;

  ShurjopaySdkPlugin({
    required this.onSuccess,
    required this.onFailed,
    required this.onDismissDialog,
  });

  void makePayment(BuildContext context, String sdkType,
      RequiredRequestData data) {
    _context = context;
    _sdkType = sdkType;
    _data = data;
    _getToken(context);
  }

  Future<void> _getToken(BuildContext context) async {
    Token token = Token(
      username: _data.username,
      password: _data.password,
      token: null,
      storeId: null,
      executeUrl: null,
      tokenType: null,
      spCode: null,
      massage: null,
      expiresIn: null,
    );
    //
    var url = Uri.parse(ApiClient.getApiClient(_sdkType).getToken());
    try {
      final response = await http.post(url, body: {
        "username": _data.username,
        "password": _data.password,
      }, headers: {
        //"Accept":   "application/json"
      });
      ErrorSuccess errorSuccess = ErrorSuccess(ESType.SUCCESS, null, "");
      /*if (response.statusCode != 200) {
        //onDismissDialog();
        errorSuccess = ErrorSuccess(ESType.ERROR, null,
            "Error post data, status code: ${response.statusCode} ${response.body}");
        onFailed(context, errorSuccess);
        return;
      }*/
      if(response.statusCode != 200) {
        onDismissDialog();
        errorSuccess = ErrorSuccess(ESType.ERROR, null,
            "Error unauthorized, status code: ${response.statusCode}");
        onFailed(context, errorSuccess);
        return;
      }
      var jsonResponse = jsonDecode(response.body);
      token = Token.fromJson(jsonDecode(response.body));
      _getExecuteUrl(context, token);
    } catch (e) {
      onDismissDialog();
      ErrorSuccess errorSuccess = ErrorSuccess(
          ESType.ERROR, null, "${e.toString()}");
      onFailed(context, errorSuccess);
    }
  }

  Future<void> _getExecuteUrl(BuildContext context, Token token) async {
    var url = Uri.parse(ApiClient.getApiClient(_sdkType).checkout());
    try {
      final response = await http.post(url, body: {
        "token": "${token.token}",
        "store_id": "${token.storeId}",
        "prefix": _data.prefix,
        "currency": _data.currency,
        "amount": "${_data.amount}",
        "order_id": _data.orderId,
        "discsount_amount": "${_data.discountAmount}",
        "disc_percent": "${_data.discPercent}",
        "client_ip": "${_data.clientIp}",
        "customer_name": _data.customerName,
        "customer_phone": _data.customerPhone,
        "customer_email": "${_data.customerEmail}",
        "customer_address": _data.customerAddress,
        "customer_city": "${_data.customerCity}",
        "customer_state": "${_data.customerState}",
        "customer_postcode": "${_data.customerPostcode}",
        "customer_country": "${_data.customerCountry}",
        "return_url": "${_data.returnUrl}",
        "cancel_url": "${_data.cancelUrl}",
        "value1": "${_data.value1}",
        "value2": "${_data.value2}",
        "value3": "${_data.value3}",
        "value4": "${_data.value4}",
      }, headers: {
        "Accept": "application/json",
        "Authorization": "${token.tokenType} ${token.token}",
      });
      //onDismissDialog();
      ErrorSuccess errorSuccess = ErrorSuccess(ESType.SUCCESS, null, "");
      if (response.statusCode != 200) {
        onDismissDialog();
        errorSuccess = ErrorSuccess(ESType.ERROR, null,
            "Error post data, status code: ${response.statusCode} ${response.body}");
        onFailed(context, errorSuccess);
        return;
      }
      CheckoutResponseData checkoutResponseData =
          CheckoutResponseData.fromJson(jsonDecode(response.body));
      _showWebView(context, token, checkoutResponseData);
    } catch (e) {
      onDismissDialog();
      ErrorSuccess errorSuccess = ErrorSuccess(
          ESType.ERROR, null, "${e.toString()}");
      onFailed(context, errorSuccess);
    }
  }

  void _showWebView(BuildContext context, Token argToken,
      CheckoutResponseData argCheckoutResponseData) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => WebViewContainer(
        requestData: _data,
        apiUrl: argCheckoutResponseData.checkoutUrl,
        sdkType: _sdkType,
        checkoutModel: argCheckoutResponseData,
        tokenModel: argToken,
        onSuccess: (BuildContext context, ErrorSuccess errorSuccess) {
          onSuccess(context, errorSuccess);
        },
        onFailed: (BuildContext context, ErrorSuccess errorSuccess) {
          onFailed(context, errorSuccess);
        },
        onDismissDialog: () {
          onDismissDialog();
        },
      ),
      settings: const RouteSettings(name: "shurjoPaySDKView"),
    ));
  }
}
