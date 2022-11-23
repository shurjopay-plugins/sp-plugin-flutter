import 'package:flutter/material.dart';
import 'package:shurjopay/controllers/checkout_controller.dart';
import 'package:shurjopay/controllers/token_controller.dart';
import 'package:shurjopay/models/checkout_request_model.dart';
import 'package:shurjopay/models/shurjopay_request_model.dart';
import 'package:shurjopay/models/token_request_model.dart';
import 'package:shurjopay/models/token_response_model.dart';
import 'package:shurjopay/utilities/functions.dart';
import 'package:shurjopay/utilities/global_objects.dart';

import '../models/checkout_response_model.dart';
import '../models/internal_response_model.dart';
import '../services/dio_service.dart';
import '../utilities/navigating.dart';
import '../views/payment_gateway_webview.dart';

class PaymentController {
  final TokenController _tokenController = TokenController();
  final CheckoutController _checkoutController = CheckoutController();
  Future<InternalResponseModel> initiate({
    required BuildContext context,
    required ShurjopayRequestModel shurjopayRequestModel,
  }) async {
    TokenRequestModel tokenRequestModel = TokenRequestModel(
      userName: shurjopayRequestModel.configs.userName,
      password: shurjopayRequestModel.configs.password,
    );
    TokenResponseModel? tokenResponseModel = TokenResponseModel();
    try {
      tokenResponseModel = await _tokenController.getToken(
        tokenRequestModel: tokenRequestModel,
      );
      if (tokenResponseModel != null &&
          tokenResponseModel.token != null &&
          tokenResponseModel.storeId != null &&
          tokenResponseModel.tokenType != null &&
          tokenResponseModel.spCode == 200) {
        await shurjoPayserviceLocator<SPDioService>().update(
          baseURL: getBaseUrl(shurjoPayserviceLocator<SPDioService>().env),
          token: tokenResponseModel.token!,
          tokenType: tokenResponseModel.tokenType!,
        );
        CheckoutRequestModel checkoutRequestModel = CheckoutRequestModel(
          token: tokenResponseModel.token!,
          storeID: tokenResponseModel.storeId!.toString(),
          prefix: shurjopayRequestModel.configs.prefix,
          currency: shurjopayRequestModel.currency,
          amount: shurjopayRequestModel.amount,
          orderID: shurjopayRequestModel.orderID,
          discountAmount: shurjopayRequestModel.discountAmount,
          discountPercentage: shurjopayRequestModel.discountPercentage,
          clientIP: shurjopayRequestModel.configs.clientIP,
          customerName: shurjopayRequestModel.customerName,
          customerPhoneNumber: shurjopayRequestModel.customerPhoneNumber,
          customerEmail: shurjopayRequestModel.customerEmail,
          customerAddress: shurjopayRequestModel.customerAddress,
          customerCity: shurjopayRequestModel.customerCity,
          customerState: shurjopayRequestModel.customerState,
          customerPostcode: shurjopayRequestModel.customerPostcode,
          customerCountry: shurjopayRequestModel.customerCountry,
          returnURL: shurjopayRequestModel.returnURL,
          cancelURL: shurjopayRequestModel.cancelURL,
          value1: shurjopayRequestModel.value1,
          value2: shurjopayRequestModel.value2,
          value3: shurjopayRequestModel.value3,
          value4: shurjopayRequestModel.value4,
        );
        CheckoutResponseModel? checkoutResponseModel = CheckoutResponseModel();
        checkoutResponseModel = await _checkoutController.checkout(
          checkoutRequestModel: checkoutRequestModel,
        );
        spPop(context: context);
        if (checkoutResponseModel != null &&
            checkoutResponseModel.checkoutUrl != null &&
            checkoutResponseModel.spOrderId != null) {
          bool? spWebViewResult;
          // ignore: use_build_context_synchronously
          spWebViewResult = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentGatewayWebview(
                checkoutURL: checkoutResponseModel!.checkoutUrl!,
                returnURL: shurjopayRequestModel.returnURL,
                cancelURL: shurjopayRequestModel.cancelURL,
              ),
            ),
          );
          if (spWebViewResult == true) {
            return InternalResponseModel(
              status: true,
              message: "Please call verifyPayment()",
              spOrderID: checkoutResponseModel.spOrderId,
            );
          } else {
            return InternalResponseModel(
              status: true,
              message: "Please call verifyPayment()",
              spOrderID: checkoutResponseModel.spOrderId,
            );
          }
        } else {
          return InternalResponseModel(
            status: false,
            message: "Something went wrong.",
          );
        }
      } else {
        spPop(context: context);
        return InternalResponseModel(
          status: false,
          errorCode: tokenResponseModel?.spCode,
          message: tokenResponseModel?.message ?? "Something went wrong.",
        );
      }
    } catch (_) {
      spPop(context: context);
      return InternalResponseModel(
        status: false,
        message: "Something went wrong.",
      );
    }
  }
}
