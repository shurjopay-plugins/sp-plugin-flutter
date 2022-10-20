import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shurjopay/models/payment_verification_model.dart';

import '../utilities/api_endpoints.dart';
import '../utilities/enums.dart';
import '../utilities/functions.dart';

class PaymentVerificationController {
  Future<ShurjopayVerificationModel> verify({required String orderID}) async {
    final Response response = await spHttpRequest(
      httpRequestType: HttpRequestType.post,
      path: ApiEndpoints.verify,
      payload: {"order_id": orderID},
    );

    if (response.data != null && response.data is String) {
      List<dynamic> decodedResponse =
          List<dynamic>.from(json.decode(response.data));
      return ShurjopayVerificationModel.fromJson(decodedResponse.first);
    }
    return ShurjopayVerificationModel.fromJson(response.data);
  }
}
