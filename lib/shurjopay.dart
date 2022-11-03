library shurjopay;

import 'package:flutter/material.dart';
import 'package:shurjopay/controllers/payment_verification_controller.dart';
import 'package:shurjopay/models/internal_response_model.dart';
import 'package:shurjopay/models/payment_verification_model.dart';
import 'package:shurjopay/models/shurjopay_request_model.dart';
import 'package:shurjopay/models/shurjopay_response_model.dart';
import 'package:shurjopay/utilities/functions.dart';
import 'package:shurjopay/utilities/navigating.dart';
import 'package:shurjopay/views/empty_loader.dart';

import 'controllers/payment_controller.dart';

class ShurjoPay {
  final PaymentController _paymentController = PaymentController();
  InternalResponseModel _internalResponseModel = InternalResponseModel();
  final PaymentVerificationController _paymentVerificationController =
      PaymentVerificationController();

  /// To initiate the payment process call this `makePayment()` function. It will verify and take you to the payment gateway.
  Future<ShurjopayResponseModel> makePayment({
    required BuildContext context,
    required ShurjopayRequestModel shurjopayRequestModel,
    Widget? loadingIndicator,
  }) async {
    spLoader(
      context: context,
      loader: EmptyLoader(loadingIndicator: loadingIndicator),
    );
    _internalResponseModel = await _paymentController.initiate(
      context: context,
      shurjopayRequestModel: shurjopayRequestModel,
    );
    printer("===== shurjoPay Log =====");
    printer("STATUS: ${_internalResponseModel.status}");
    printer("CODE: ${_internalResponseModel.errorCode}");
    printer("MESSAGE: ${_internalResponseModel.message}");
    return ShurjopayResponseModel(
      status: _internalResponseModel.status,
      errorCode: _internalResponseModel.errorCode,
      message: _internalResponseModel.message,
      shurjopayOrderID: _internalResponseModel.spOrderID,
    );
  }

  /// `verifyPayment()` function is being used to get all the necessary data of an order. Please call this function to verify your transaction.
  Future<ShurjopayVerificationModel> verifyPayment(
      {required String orderID}) async {
    ShurjopayVerificationModel shurjopayVerificationModel =
        ShurjopayVerificationModel();
    shurjopayVerificationModel =
        await _paymentVerificationController.verify(orderID: orderID);
    return shurjopayVerificationModel;
  }
}
